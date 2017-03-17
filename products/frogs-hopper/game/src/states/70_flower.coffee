###
  # ecrit par fc
  # le  2016
  # description :
###

class Phacker.Game.Flower

  constructor: (@gm, @prm) -> #prm ={x,y,way #left or right#}
      @_fle_   = 'Flower'
      @make_flower()
      @make_twn_escape() # that's a tween for escaping bird


  #.----------.----------
  # draw the bird
  #.----------.----------

  make_flower: ->

      @flw = @gm.add.sprite @prm.x0 , @prm.y0 - 10, 'bonus'  #2 9x 29
      @flw.anchor.setTo(0.5, 1) # anchor in the middle of bottomn
      @gm.physics.enable( @flw, Phaser.Physics.ARCADE)
      #@flw.body.gravity.y = 500


  #.----------.----------
  # make tween  : escape when sprite collide leaf of lly
  #.----------.----------

  make_twn_escape:  -> #smooth escape
    @twn_escape = @gm.add.tween @flw
    @twn_escape.to(
      { x: "-20" }
      150, Phaser.Easing.Linear.None
    )
    @twn_escape.onComplete.addOnce(
      ->
        e = @gm.add.tween(@flw);
        e.to { y: "+150" }, 200, Phaser.Easing.Cubic.In
        e.start()
      this
    )

 