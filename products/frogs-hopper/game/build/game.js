(function() {
  Phacker.Game.Socle = (function() {
    function Socle(gm) {
      this.gm = gm;
      this._fle_ = 'Socle';
      this.glob = this.gm.ge.parameters = {};
      this.glob.bg = {
        x0: 0,
        y0: 48,
        w: this.gm.gameOptions.fullscreen ? 375 : 768,
        h: this.gm.gameOptions.fullscreen ? 559 - 48 : 500 - 48,
        middleX: this.gm.gameOptions.fullscreen ? 187 : 384
      };
      this.draw_bg();
    }

    Socle.prototype.draw_bg = function() {
      this.bg = this.gm.add.sprite(this.glob.bg.x0, this.glob.bg.y0, 'bg_gameplay');
      this.bg.fixedToCamera = true;
      this.bg_btn = this.gm.add.sprite(this.glob.bg.x0, this.glob.bg.y0, 'bg_gameplay');
      this.bg_btn.fixedToCamera = true;
      this.bg_btn.alpha = 0;
      this.bg_btn.inputEnabled = true;
      return this.bg_btn.bringToTop();
    };

    return Socle;

  })();

}).call(this);

(function() {
  Phacker.Game.One_waterlily = (function() {
    function One_waterlily(gm, prm) {
      this.gm = gm;
      this.prm = prm;
      this._fle_ = 'One waterlily';
      this.glob = this.gm.ge.parameters;
      this.glob.cylinder = {
        w: 10,
        h: 25
      };
      this.glob.ellipse = {
        w: 160,
        h: 80
      };
      this.position = {
        top: {
          x: 0,
          y: 0
        },
        bottom: {
          x: 0,
          y: 0
        }
      };
      this.has_appeared = false;
      this.wl = this.gm.add.physicsGroup();
      this.wl.enableBody = true;
      this.cldr = [];
      this.hat = '';
      this.make_waterlily(this.prm.h, this.prm.x, this.prm.y, this.prm.scale);
      this.make_tween_climb();
    }

    One_waterlily.prototype.make_waterlily = function(h, x0, y0, scale) {
      var c, foo, i, ref;
      c = this.gm.add.sprite(x0, y0, "cylinder");
      this.cldr.push(c);
      c.anchor.setTo(.5, 1);
      c.alpha = this.prm.init ? 1 : .1;
      this.position.bottom = {
        x: x0,
        y: y0
      };
      for (foo = i = 0, ref = h - 2; 0 <= ref ? i <= ref : i >= ref; foo = 0 <= ref ? ++i : --i) {
        y0 -= this.glob.cylinder.h;
        c = this.gm.add.sprite(x0, y0, "cylinder");
        this.cldr.push(c);
        c.anchor.setTo(.5, 1);
        c.alpha = this.prm.init ? 1 : .1;
      }
      y0 -= this.glob.cylinder.h - 5;
      this.hat = this.wl.create(x0, y0, "ellipse");
      this.hat.body.setSize(60, 25, 60, 75);
      this.hat.scale.setTo(scale, scale);
      this.hat.anchor.setTo(.5, 1);
      this.hat.body.immovable = true;
      this.hat.alpha = this.prm.init ? 1 : .1;
      this.hat.prms = this.prms;
      this.position.top = {
        x: this.hat.x,
        y: this.hat.y
      };
      return this.gm.world.bringToTop(this.wl);
    };

    One_waterlily.prototype.make_tween_appear = function() {
      var y1;
      y1 = this.hat.y;
      return this.appear = this.gm.add.tween(this.hat).to({
        y: y1
      }, 500, Phaser.Easing.Linear.None);
    };

    One_waterlily.prototype.make_tween_climb = function() {
      this.twn_climb = this.gm.add.tween(this.hat);
      this.twn_climb.to({
        y: "+15"
      }, 150, Phaser.Easing.Linear.None);
      return this.twn_climb.onComplete.addOnce(function() {
        var e;
        e = this.gm.add.tween(this.hat);
        e.to({
          y: "-15"
        }, 150, Phaser.Easing.Linear.None);
        return e.start();
      }, this);
    };

    One_waterlily.prototype.finalize = function(dx) {

      /*if not @has_appeared
          @has_appeared = true
      
          @hat.alpha = 1
          @scale @prm.scale *.25
          for c in @cldr  then c.alpha = 1
          #@appear.start()
           *
       */
      var sc;
      sc = this.prm.scale * (2 - dx / 50);
      return this.scale(sc);
    };

    One_waterlily.prototype.scale = function(scl) {
      var i, n, ref, stem, y;
      for (n = i = 0, ref = this.cldr.length - 1; 0 <= ref ? i <= ref : i >= ref; n = 0 <= ref ? ++i : --i) {
        stem = this.cldr[n];
        y = this.prm.y - n * this.glob.cylinder.h * scl;
        stem.y = y;
        stem.scale.setTo(scl, scl);
      }
      y -= this.glob.cylinder.h * scl;
      this.hat.y = y;
      this.hat.scale.setTo(scl, scl);
      return this.position.top.y = y;
    };

    One_waterlily.prototype.alpha = function(a) {
      var i, n, ref;
      for (n = i = 0, ref = this.cldr.length - 1; 0 <= ref ? i <= ref : i >= ref; n = 0 <= ref ? ++i : --i) {
        this.cldr[n].alpha = a;
      }
      return this.hat.alpha = a;
    };

    One_waterlily.prototype.moveTo = function(x, y) {
      var i, n, ref, stem, yy;
      for (n = i = 0, ref = this.cldr.length - 1; 0 <= ref ? i <= ref : i >= ref; n = 0 <= ref ? ++i : --i) {
        stem = this.cldr[n];
        yy = y - n * this.cylinder.h * this.prm.scale;
        stem.y = yy;
        stem.x = x;
        this.bottom.x = x;
        this.bottom.y = y;
      }
      yy -= this.cylinder.h * this.prm.scale;
      this.hat.x = x;
      this.hat.y = yy;
      this.top.x = x;
      return this.top.y = yy - this.hat.body.height * this.prm.scale;
    };

    One_waterlily.prototype.destroy = function() {
      var c, i, len, ref, results;
      this.wl.destroy();
      ref = this.cldr;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        c = ref[i];
        results.push(c.destroy());
      }
      return results;
    };

    return One_waterlily;

  })();

}).call(this);

(function() {
  Phacker.Game.Waterlilies = (function() {
    function Waterlilies(gm) {
      this.gm = gm;
      this._fle_ = 'Waterlilies';
      this.glob = this.gm.ge.parameters;
      this.glob.wly = {
        x0: this.gm.gameOptions.fullscreen ? this.glob.bg.w - 70 : this.glob.bg.w - 250,
        y0: this.glob.bg.h + 20,
        h0: 3,
        scale0: .65,
        dxmax: 275,
        dymax: 162,
        tan: 162 / 275,
        way: 'left'
      };
      this.left_or_right = ['left', 'right'];
      this.wls = [];
      this.make_lily();
      this.make_lily();
      this.make_lily();
    }

    Waterlilies.prototype.make_lily = function() {
      var hxys, x0, y0;
      if (this.wls.length === 0) {
        this.wls.push(new Phacker.Game.One_waterlily(this.gm, {
          h: this.glob.wly.h0,
          x: this.glob.bg.middleX,
          y: this.glob.wly.y0,
          scale: this.glob.wly.scale0,
          init: true,
          way: 'left'
        }));
      } else if (this.wls.length === 1) {
        this.wls.push(new Phacker.Game.One_waterlily(this.gm, {
          h: this.glob.wly.h0,
          x: this.glob.bg.middleX - 120,
          y: this.glob.wly.y0 - 71,
          scale: this.glob.wly.scale0,
          init: true,
          way: 'left'
        }));
      } else {
        x0 = this.wls[1].position.bottom.x;
        y0 = this.wls[1].position.bottom.y;
        hxys = this.hxy_scale(x0, y0);
        this.wls.push(new Phacker.Game.One_waterlily(this.gm, hxys));
      }
      if (this.spt != null) {
        return this.spt.bringToTop();
      }
    };

    Waterlilies.prototype.hxy_scale = function(x0, y0) {
      var dx, wway, x, y;
      wway = this.left_or_right[this.gm.rnd.integerInRange(0, 1)];
      if (this.wls[0].prm.way === wway) {
        dx = this.gm.rnd.integerInRange(1, 2);
      } else {
        dx = this.gm.rnd.integerInRange(2, 2);
      }
      dx = (3 + dx) * this.glob.wly.dxmax / 8;
      x = wway === 'left' ? x0 - dx : x0 + dx;
      y = y0 - this.glob.wly.tan * dx;
      return {
        h: 3,
        x: x,
        y: y,
        scale: this.glob.wly.scale0,
        way: wway
      };
    };

    Waterlilies.prototype.add_destroy = function(spt) {
      var dx, w;
      w = this.wls[0];
      if (w.position.top.y - spt.y > 80) {
        w.destroy();
        this.wls.splice(0, 1);
        this.make_lily();
      }
      dx = spt.y - this.wls[2].position.bottom.y;
      if (((50 < dx && dx < 100)) && spt.body.velocity.y < 0) {
        this.wls[2].alpha(1);
        return this.wls[2].finalize(dx);
      }
    };

    Waterlilies.prototype.bind_spt = function(spt) {
      return this.spt = spt;
    };

    return Waterlilies;

  })();

}).call(this);

(function() {
  Phacker.Game.My_mouse = (function() {
    function My_mouse(gm, socleO) {
      this.gm = gm;
      this.socleO = socleO;
      this._fle_ = 'Mouse';
      this.glob = this.gm.ge.parameters;
      this.reset();
      this.bg_set_mouse_event();
    }

    My_mouse.prototype.bg_set_mouse_event = function() {
      this.socleO.bg_btn.events.onInputDown.add(this.on_mouse_down, this);
      return this.socleO.bg_btn.events.onInputUp.add(this.on_mouse_up, this);
    };

    My_mouse.prototype.on_mouse_down = function() {
      this.glob.mouse.down = true;
      this.glob.mouse.down_ms = new Date().getTime();
      return this.glob.mouse.dt = 0;
    };

    My_mouse.prototype.on_mouse_up = function() {
      var l, wly;
      this.glob.mouse.down = false;
      this.glob.mouse.dt = new Date().getTime() - this.glob.mouse.down_ms;
      if (this.glob.mouse.dt > this.glob.mouse.maxTime) {
        this.glob.mouse.dt = this.glob.mouse.maxTime;
      }
      this.glob.mouse.dt = 4.5 / 7 * this.glob.mouse.dt + 250;
      this.glob.mouse.down_ms = 0;
      l = this.wls.length;
      wly = this.wls[l - 2];
      return wly.twn_climb.start();
    };

    My_mouse.prototype.when_down = function() {
      var dt, dy, wly;
      wly = this.wls[1];
      if (this.glob.mouse.down) {
        wly.hat.bringToTop();
        dt = new Date().getTime() - this.glob.mouse.down_ms;
        dy = Math.floor(dt / this.glob.mouse.maxTime * 50);
        if (dy >= 50) {
          dy = 50;
        }
        return wly.hat.y = wly.position.top.y + dy;
      }
    };

    My_mouse.prototype.reset = function() {
      return this.glob.mouse = {
        x: 0,
        y: 0,
        down: false,
        down_ms: 0,
        dt: 0,
        maxTime: 700,
        min: 150
      };
    };

    My_mouse.prototype.bind = function(waterliliesO) {
      return this.wls = waterliliesO.wls;
    };

    return My_mouse;

  })();

}).call(this);

(function() {
  Phacker.Game.Sprite = (function() {
    function Sprite(gm, waterliliesO) {
      this.gm = gm;
      this.waterliliesO = waterliliesO;
      this._fle_ = 'Sprite';
      this.wls = this.waterliliesO.wls;
      this.glob = this.gm.ge.parameters;
      this.glob.spt = {
        reseting: true,
        has_collided: true,
        jumping: false,
        tooLow: false,
        max_height: 700,
        w: 72,
        h: 77,
        message: 'not used yet',
        angle: 15
      };
      this.mouse = this.glob.mouse;
      this.glob.jmp = {
        vy: this.glob.wly.dxmax / this.glob.wly.dymax * .45,
        vx: .6,
        g: 700
      };
      this.spt = this.gm.add.sprite(this.wls[0].position.top.x, this.wls[0].position.top.y - 20, 'character_sprite', 6);
      this.gm.physics.arcade.enable(this.spt);
      this.spt.body.gravity.y = this.glob.jmp.g;
      this.spt.body.setSize(70, 30, 1, 47);
      this.spt.scale.setTo(.8, .8);
      this.spt.anchor.setTo(0.5, 1);
      this.spt.angle = this.glob.spt.angle;
      this.anim_jump = this.spt.animations.add('jmp', [1, 2, 1, 0, 3], 15, false);
      this.anim_jump.onComplete.add(this.turnJ, this);
      this.anim_down = this.spt.animations.add('dwn', [0, 1, 2, 1, 0], 20, false);
      this.anim_down.onComplete.add(this.turn, this);
      this.make_tween_go_center_lily(1.2, 1.2);
      this.turn();
    }

    Sprite.prototype.collide = function(waterlilies) {
      var i, len, wls;
      for (i = 0, len = waterlilies.length; i < len; i++) {
        wls = waterlilies[i];
        if (this.gm.physics.arcade.collide(this.spt, wls.wl, function() {
          return true;
        }, function(spt, wls) {
          return this.when_collide(spt, wls);
        }, this)) {
          return this.glob.spt.message;
        }
      }
      return 'nothing';
    };

    Sprite.prototype.when_collide = function(spt, wly) {
      var ref;
      if (!this.glob.spt.has_collided) {
        spt.bringToTop();
        spt.body.velocity.x = 0;
        this.waterliliesO.wls[1].scale(this.waterliliesO.wls[1].prm.scale);
        this.glob.spt.has_collided = true;
        this.glob.spt.jumping = false;
        this.spt.animations.play('dwn');
        this.glob.spt.max_height = spt.y + 10;
        if (wly.key === "ellipse") {
          if ((-4 < (ref = wly.y - spt.y - wly.body.height) && ref < 4)) {
            return this.glob.spt.message = "win";
          } else {
            return this.glob.spt.message = "loose ellipse";
          }
        } else {
          return this.glob.spt.message = "loose cylinder";
        }
      } else {
        return this.glob.spt.message = 'nothing';
      }
    };

    Sprite.prototype.jump = function() {
      if (!this.mouse.down && this.mouse.dt > 0 && !this.glob.spt.jumping) {
        if (this.spt.body == null) {
          return;
        }
        this.spt.animations.play('jmp');
        this.glob.spt.jumping = true;
        this.glob.spt.has_collided = false;
        this.glob.spt.reseting = false;
        this.spt.y -= 20;
        this.spt.body.velocity.y = -this.mouse.dt * this.glob.jmp.vy;
        this.spt.body.velocity.x = this.waterliliesO.wls[1].prm.way === 'left' ? -this.mouse.dt * this.glob.jmp.vx : this.mouse.dt * this.glob.jmp.vx;
      }
      return this.mouse.dt = 0;
    };

    Sprite.prototype.make_tween_go_center_lily = function(x0, y0) {
      this.go_center_lily = this.gm.add.tween(this.spt.scale);
      return this.go_center_lily.to({
        x: x0,
        y: y0
      }, 150, Phaser.Easing.Back.InOut).yoyo(true);
    };

    Sprite.prototype.check_height = function(spt) {
      if (this.glob.spt.tooLow) {
        return 'too low yet';
      }
      if ((spt.y > this.wls[0].hat.y + 5) && (spt.body.velocity.y > 5) && !this.glob.spt.reseting) {
        this.glob.spt.tooLow = true;
        return 'loose';
      } else {
        return 'ok';
      }
    };

    Sprite.prototype.turn = function() {
      if (this.wls[1].prm.way === 'left') {
        this.spt.scale.setTo(.8, .8);
        return this.spt.angle = this.glob.spt.angle;
      } else {
        this.spt.scale.setTo(-.8, .8);
        return this.spt.angle = -this.glob.spt.angle;
      }
    };

    Sprite.prototype.turnJ = function() {
      if (this.spt.angle > 0) {
        return this.spt.angle = -this.glob.spt.angle;
      } else {
        return this.spt.angle = this.glob.spt.angle;
      }
    };

    return Sprite;

  })();

}).call(this);


/*
    ----------------------
    fc 2017-03-05
    camera
    ----------------------
 */

(function() {
  Phacker.Game.My_camera = (function() {
    function My_camera(gm, waterliliesO) {
      this.gm = gm;
      this.waterliliesO = waterliliesO;
      this._fle_ = 'Camera';
      this.glob = this.gm.ge.parameters;
      this.offset = {
        xl: this.glob.wly.x0 - 20,
        xr: this.gm.gameOptions.fullscreen ? 100 : 210,
        y: this.glob.wly.y0 - 54
      };
      this.speed = 4;
    }

    My_camera.prototype.move = function(spt) {
      var ddx, way;
      way = this.waterliliesO.wls[1].prm.way;
      ddx = way === 'left' ? this.gm.camera.x - spt.x + this.offset.xl : this.gm.camera.x - spt.x + this.offset.xr;
      if (Math.abs(ddx) > this.speed) {
        if (ddx > 0) {
          this.gm.camera.x -= this.speed;
        } else {
          this.gm.camera.x += this.speed;
        }
      } else {
        this.gm.camera.x = way === 'left' ? spt.x - this.offset.xl : spt.x - this.offset.xr;
      }
      if (this.gm.camera.y > spt.y - this.offset.y) {
        return this.gm.camera.y = spt.y - this.offset.y;
      }
    };

    return My_camera;

  })();

}).call(this);

(function() {
  Phacker.Game.Effects = (function() {
    function Effects(gm) {
      this.gm = gm;
      this._fle_ = 'Effect';
      this.effects = ['effect1', 'effect3', 'effect2'];
    }

    Effects.prototype.play = function(spriteO) {
      var n;
      n = this.gm.rnd.integerInRange(0, 1);
      this.eff = this.gm.add.sprite(50, 100, this.effects[n], 2);
      this.eff.anchor.setTo(0.5, 0.5);
      this.eff.animations.add('explode', [2, 1, 0, 1], 8, true);
      this.eff.x = spriteO.spt.x;
      this.eff.y = spriteO.spt.y - spriteO.spt.height;
      return this.eff.animations.play('explode');
    };

    Effects.prototype.stop = function() {
      return this.eff.destroy();
    };

    return Effects;

  })();

}).call(this);

(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  this.YourGame = (function(superClass) {
    extend(YourGame, superClass);

    function YourGame() {
      return YourGame.__super__.constructor.apply(this, arguments);
    }

    YourGame.prototype.update = function() {
      var mess1, mess2;
      YourGame.__super__.update.call(this);
      this._fle_ = 'Jeu, update';
      mess1 = this.spriteO.collide(this.wls);
      if (mess1 === 'win') {
        this.win();
      }
      this.spriteO.jump();
      this.mouseO.when_down();
      this.camO.move(this.spt);
      mess2 = this.spriteO.check_height(this.spt);
      if (mess2 === 'loose') {
        this.spt.destroy();
        this.effectO.play(this.spriteO);
        this.lostLife();
      }
      return this.waterliliesO.add_destroy(this.spt);
    };

    YourGame.prototype.resetPlayer = function() {
      console.log("Reset the player");
      this.spriteO = new Phacker.Game.Sprite(this.game, this.waterliliesO);
      this.spt = this.spriteO.spt;
      this.wls[1].scale(this.wls[1].prm.scale);
      return this.effectO.stop();
    };

    YourGame.prototype.create = function() {
      YourGame.__super__.create.call(this);
      this.game.physics.startSystem(Phaser.Physics.ARCADE);
      this.game.world.setBounds(-150000, -150000, 300000, 151000);
      this.socleO = new Phacker.Game.Socle(this.game);
      this.mouseO = new Phacker.Game.My_mouse(this.game, this.socleO);
      this.waterliliesO = new Phacker.Game.Waterlilies(this.game);
      this.wls = this.waterliliesO.wls;
      this.mouseO.bind(this.waterliliesO);
      this.spriteO = new Phacker.Game.Sprite(this.game, this.waterliliesO);
      this.spt = this.spriteO.spt;
      this.waterliliesO.bind_spt(this.spt);
      this.camO = new Phacker.Game.My_camera(this.game, this.waterliliesO);
      this.effectO = new Phacker.Game.Effects(this.game);
      return this.glob = this.game.ge.parameters;
    };

    return YourGame;

  })(Phacker.GameState);

}).call(this);
