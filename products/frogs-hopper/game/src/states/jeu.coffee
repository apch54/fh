#   fc : 2017-03-01
#             _    _
#            (@)--(@)
#           /.______.\
#           \________/
#          ./        \.
#         ( .        , )
#          \ \_\\//_/ /
#           ~~  ~~  ~~
#

class @YourGame extends Phacker.GameState

    update: ->
        super() #Required
        @_fle_ = 'Jeu, update'

        mess1 = @spriteO.collide @wls # test message from game
        if mess1 is 'win' then @win()
        else if mess1 is "bonus" then @winBonus()

        #console.log "- #{@_fle_} : ",mess
        @spriteO.jump()
        @mouseO.when_down()
        @camO.move @spt

        mess2 = @spriteO.check_height(@spt)
        if mess2 is 'loose'
            #console.log "- #{@_fle_} : ",mess2
            @spt.destroy()
            @effectO.play @spriteO
            @lostLife()

        @waterliliesO.add_destroy @spt
        @socleO.move_extra(@camO)

    resetPlayer: ->
        #console.log "Reset the player"
        @wls[0].scale  @wls[0].prm.scale
        @wls[0].flw.flw.alpha = 0 if @wls[0].flw?

        @spriteO = new Phacker.Game.Sprite @game, @waterliliesO
        @spt = @spriteO.spt
        @wls[1].scale  @wls[1].prm.scale
        @effectO.stop() # destroy effect

    create: ->
        super() #Required

        @game.physics.startSystem(Phaser.Physics.ARCADE)
        @game.world.setBounds(-150000, -150000, 300000,  151000) # offset x, offsety, w, h

        @socleO = new Phacker.Game.Socle(@game)
        @mouseO = new Phacker.Game.My_mouse @game, @socleO

        #@one_waterlilyO = new Phacker.Game.One_waterlily(@game,5, 200, 400)

        @waterliliesO = new Phacker.Game.Waterlilies(@game)
        @wls = @waterliliesO.wls #array of lilies
        @mouseO.bind @waterliliesO

        @spriteO = new Phacker.Game.Sprite @game, @waterliliesO
        @spt = @spriteO.spt
        @waterliliesO.bind_spt @spt

        @camO = new Phacker.Game.My_camera @game , @waterliliesO
        @effectO = new Phacker.Game.Effects @game

        @glob = @game.ge.parameters


