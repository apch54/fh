# fc : 2017-02-06


class Phacker.Game.Effects

    constructor:(@gm) ->
        @_fle_      ='Effect'
        @effects = ['effect1','effect3','effect2']

    #.----------.----------
    # play animation & stop
    # create effect on live for effect must be over lilies
    #.----------.----------

    play:(spriteO) ->#

        n = @gm.rnd.integerInRange 0, 1 # choose animation

        @eff= @gm.add.sprite 50, 100, @effects[n] ,2 #86x88 & create effect
        @eff.anchor.setTo(0.5, 0.5) # anchor in the middle of bottom
        @eff.animations.add  'explode', [2, 1, 0, 1], 8, true
        @eff.x = spriteO.spt.x   #set effect location
        @eff.y = spriteO.spt.y - spriteO.spt.height
        @eff.animations.play 'explode'

    stop: -> @eff.destroy()

