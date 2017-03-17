###
  # ecrit par fc
  # le  2016
  # description :
###

class Phacker.Game.Flower

  constructor: (@gm, @prm) -> #prm ={x,y,way #left or right#, visible}
      @_fle_   = 'Flower'
      @make_flower()
      @make_twn_escape() # that's a tween for escaping bird
      #console.log "- #{@_fle_} : ",@prm


  #.----------.----------
  # draw the bird
  #.----------.----------
  make_flower: ->

      yy =  @prm.y0 - @gm.rnd.integerInRange 10, 25 # choose animation
      xx = @gm.rnd.integerInRange 20, 50 # choose animation
      xx = if @prm.way is 'left' then @prm.x0 - xx else  @prm.x0 + xx

      @flw = @gm.add.sprite xx ,yy, 'bonus'  #2 9x 29
      @flw.anchor.setTo(0.5, 1) # anchor in the middle of bottomn
      @gm.physics.enable( @flw, Phaser.Physics.ARCADE)
      #@flw.body.gravity.y = 500
      if not @prm.visible then @flw.alpha = 0



  #.----------.----------
  # make tween  : escape when sprite collide leaf of lily leafe
  # 2 step : horizontal then vertical
  #.----------.----------
  make_twn_escape:  -> #smooth lily flower escaping

    x1 = @gm.rnd.integerInRange 40, 80
    x1 = if @prm.way is 'left'  then @flw.x - x1 else @flw.x + x1
    y1 = @flw.y + 10
    x2 = @gm.rnd.integerInRange 40, 80
    x2 = if @prm.way is 'left'  then  x1 - x2 else x1 + x2
    y2 = @flw.y + 150

    @twn_escape = @gm.add.tween @flw
    @twn_escape.to(
      { x: x1, y:@flw.y - 10 }
      200, Phaser.Easing.Bounce.In
    )
    @twn_escape.onComplete.addOnce(
      ->
        e = @gm.add.tween(@flw);
        e.to { x: x2, y: y2 }, 300, Phaser.Easing.Cubic.In
        e.start()
      this
    )

