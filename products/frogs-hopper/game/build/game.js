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
        middleX: this.gm.gameOptions.fullscreen ? 279 : 384
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

      /*
      #clouds -----
      @cloud  = @gm.add.sprite -@glob.cloud.lx , @glob.bg.y0, 'cloud'  # 768x170
      #@cloud.fixedToCamera = true
      @cloud_tween = @gm.add.tween (@cloud)
      @cloud_tween.to( {  y:[ @glob.bg.y0 + 25 ,@glob.bg.y0 ] }, 8333, Phaser.Easing.Linear.None, true, 0, -1 )
      
      
      #seas -----
      
      @sea3   = @gm.add.sprite 0, @glob.sea.y03, 'sea3'  # 768x61
      #@sea3.fixedToCamera = true
      @sea3_tween = @gm.add.tween (@sea3)
      @sea3_tween.to( {  y:[@glob.sea.y03 - 10, @glob.sea.y03] }, 3000, Phaser.Easing.Linear.None, true, 0, -1 )
      
      @sea2   = @gm.add.sprite 0, @glob.sea.y02 , 'sea2'  # 768x44
      #@sea2.fixedToCamera = true
      @sea2_tween = @gm.add.tween (@sea2)
      @sea2_tween.to( {  y:[@glob.sea.y02 - 10, @glob.sea.y02] }, 2300, Phaser.Easing.Linear.None, true, 0, -1 )
      
      @sea1   = @gm.add.sprite 0, @glob.sea.y01 , 'sea1'  # 768x39
      #@sea1.fixedToCamera = true
      @sea1_tween = @gm.add.tween (@sea1)
      @sea1_tween.to( {  y:[@glob.sea.y01 + 5, @glob.sea.y01] }, 1600, Phaser.Easing.Linear.None, true, 0, -1 )
      
      
          #.----------.----------
           * handle last sea to get column inside sea
           * used for drawing a column
           *  & destroy to have column beside sea
          #.----------.----------
      
          * draw_last_sea : -> # not used
              * @sea1   = @gm.add.sprite 0, @glob.sea.y01 , 'sea1'  # 768x39
      #@sea1.fixedToCamera = true
      #@sea1_tween = @gm.add.tween (@sea1)
      #@sea1_tween.to( {  y:[@glob.sea.y01 + 5, @glob.sea.y01] }, 1600, Phaser.Easing.Linear.None, true, 0, -1 )
      
      
          destroy_last_sea : -> @sea1.destroy()
      
          #.----------.----------
           * fit sea.x with cam
          #.----------.----------
          move_with_cam:(camx)->
      
      @glob.cloud.dx += @glob.cloud.vx
      if  @glob.cloud.dx > @glob.cloud.lx then  @glob.cloud.vx *= -1
      else if @glob.cloud.dx < 0  then @glob.cloud.vx *= -1
      
      @sea3.x = camx
      @sea2.x = camx
      if @sea1? then @sea1.x = camx
      
      @cloud.x = camx + @glob.cloud.dx - @glob.cloud.lx
       */
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
      this.prm.position = this.position;
      this.prm.has_appeared = false;
      this.wl = this.gm.add.physicsGroup();
      this.wl.enableBody = true;
      this.cldr = [];
      this.hat = '';
      this.make_waterlily(this.prm.h, this.prm.x, this.prm.y, this.prm.scale);
      this.make_tween_appear();
      this.make_tween_climb();
    }

    One_waterlily.prototype.make_waterlily = function(h, x0, y0, scale) {
      var c, foo, i, ref;
      c = this.wl.create(x0, y0, "cylinder");
      this.cldr.push(c);
      c.anchor.setTo(.5, 1);
      c.body.setSize(12, 25, 84, 0);
      c.body.immovable = true;
      c.alpha = this.prm.init ? 1 : .1;
      this.position.bottom = {
        x: x0,
        y: y0
      };
      for (foo = i = 0, ref = h - 2; 0 <= ref ? i <= ref : i >= ref; foo = 0 <= ref ? ++i : --i) {
        y0 -= this.glob.cylinder.h;
        c = this.wl.create(x0, y0, "cylinder");
        this.cldr.push(c);
        c.anchor.setTo(.5, 1);
        c.body.setSize(12, 25, 84, 0);
        c.body.immovable = true;
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
      return this.position.top = {
        x: this.hat.x,
        y: this.hat.y
      };
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
      return this.twn_climb.to({
        y: this.position.top.y
      }, 500, Phaser.Easing.Linear.None);
    };

    One_waterlily.prototype.finalize = function() {
      var c, i, len, ref;
      if (!this.prm.has_appeared) {
        this.prm.has_appeared = true;
        this.hat.y += 50;
        this.hat.alpha = 1;
        ref = this.cldr;
        for (i = 0, len = ref.length; i < len; i++) {
          c = ref[i];
          c.alpha = 1;
        }
        return this.appear.start();
      }
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
      wway = 'right';
      dx = this.gm.rnd.integerInRange(0, 2);
      dx = (3 + dx) * this.glob.wly.dxmax / 7;
      x = wway === 'left' ? x0 - dx : x0 + dx;
      y = y0 - this.glob.wly.dymax / this.glob.wly.dxmax * dx;
      return {
        h: 3,
        x: x,
        y: y,
        scale: this.glob.wly.scale0,
        way: wway
      };
    };

    Waterlilies.prototype.add_destroy = function(spt) {
      var w;
      w = this.wls[0];
      if (w.position.top.y - spt.y > 80) {
        w.wl.destroy();
        this.wls.splice(0, 1);
        this.make_lily();
      }
      if ((spt.y - this.wls[2].position.bottom.y) < 70) {
        return this.wls[2].finalize();
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
      this.glob.mouse.down_ms = 0;
      l = this.wls.length;
      wly = this.wls[l - 2];
      return wly.twn_climb.start();
    };

    My_mouse.prototype.when_down = function() {
      var dt, dy, wly;
      wly = this.wls[1];
      if (this.glob.mouse.down) {
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
        has_collided: true,
        jumping: false,
        max_height: 420,
        w: 72,
        h: 77,
        message: 'not used yet'
      };

      /*.----------.----------
      @has_collided = true
      #@vy = gameOptions.spring_power # ratio vx per 1/60 sec for jumping
      @hit_resp = ''
      @too_low = false
      @is_reseting = true
       */
      this.mouse = this.glob.mouse;
      this.glob.jmp = {
        vy: this.glob.wly.dxmax / this.glob.wly.dymax * .45,
        vx: .45,
        g: 700
      };
      this.spt = this.gm.add.sprite(this.wls[0].position.top.x, this.wls[0].position.top.y - 20, 'character_sprite', 6);
      this.gm.physics.arcade.enable(this.spt);
      this.spt.body.bounce.set(0);
      this.spt.body.gravity.y = this.glob.jmp.g;
      this.spt.body.setSize(70, 30, 1, 47);
      this.spt.anchor.setTo(0.5, 1);
      this.spt.angle = 20;
      this.anim_jump = this.spt.animations.add('jmp', [1, 2, 1, 0, 3], 20, false);
      this.anim_down = this.spt.animations.add('dwn', [0, 1, 2, 1, 0], 20, false);
      this.anim_down.onComplete.add(this.turn, this);
      this.spt.frame = 0;
      this.make_tween_go_center_lily(1.2, 1.2);
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
        spt.body.velocity.x = 0;
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
        this.spt.body.velocity.y = -this.mouse.dt * this.glob.jmp.vy;
        console.log("- " + this._fle_ + " : ", this.waterliliesO.wls[1].prm.way);
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
      if (spt.y > this.glob.spt.max_height) {
        return 'loose';
      } else {
        return 'ok';
      }
    };

    Sprite.prototype.turn = function() {
      if (this.wls[1].prm.way === 'left') {
        this.spt.scale.setTo(.8, .8);
        return this.spt.angle = 20;
      } else {
        this.spt.scale.setTo(-.8, .8);
        return this.spt.angle = -20;
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
        xl: this.glob.wly.x0,
        xr: this.gm.gameOptions.fullscreen ? 70 : 210,
        y: this.glob.wly.y0 - 54
      };
      this.speed = 4;
    }

    My_camera.prototype.move = function(spt) {
      var way;
      way = this.waterliliesO.wls[1].prm.way;
      if (way === 'left') {
        if ((this.gm.camera.x - spt.x + this.offset.xl) < -this.speed) {
          this.gm.camera.x += this.speed;
        } else {
          this.gm.camera.x = spt.x - this.offset.xl;
        }
      } else {
        if ((spt.x - this.offset.xr - this.gm.camera.x) > this.speed) {
          this.gm.camera.x += this.speed;
        } else {
          this.gm.camera.x = spt.x - this.offset.xr;
        }
      }
      if ((this.gm.camera.y - spt.y - this.offset.y) > this.speed) {
        return this.gm.camera.y -= this.speed;
      } else {
        return this.gm.camera.y = spt.y - this.offset.y;
      }
    };

    return My_camera;

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
      YourGame.__super__.update.call(this);
      this._fle_ = 'Jeu, update';
      this.spriteO.collide(this.wls);
      this.spriteO.jump();
      this.mouseO.when_down();
      this.camO.move(this.spt);
      this.spriteO.check_height(this.spt);
      return this.waterliliesO.add_destroy(this.spt);
    };

    YourGame.prototype.resetPlayer = function() {
      return console.log("Reset the player");
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
      return this.glob = this.game.ge.parameters;
    };

    return YourGame;

  })(Phacker.GameState);

}).call(this);
