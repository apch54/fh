
#-------------------------------------------------!
#            ####                  ####           !
#            ####=ooO=========Ooo= ####           !
#            ####  \\  (o o)  //   ####           !
#               --------(_)--------               !
#              --. ..- ...  .. ...   −− .         !
#-------------------------------------------------!
#                socle: 2017/01/16                !
#                      apch                       !
#-------------------------------------------------!


class Phacker.Game.Socle

    constructor: (@gm) ->
        @_fle_          = 'Socle'
        @glob = @gm.ge.parameters = {}


        @glob.bg = # global parameter"
            x0  : 0
            y0  : 48 # background
            w   : if @gm.gameOptions.fullscreen  then 375 else 768
            h   : if @gm.gameOptions.fullscreen  then 559 - 48 else 500 - 48
            middleX: if @gm.gameOptions.fullscreen  then 187 else 384

        @draw_bg()
        #@draw_last_sea()

    #.----------.----------
    # build socle
    #.----------.----------

    draw_bg :  ->
        @bg      = @gm.add.sprite @glob.bg.x0, @glob.bg.y0, 'bg_gameplay'  # 768x500
        @bg.fixedToCamera = true

        #srcreen = button
        @bg_btn  = @gm.add.sprite @glob.bg.x0, @glob.bg.y0, 'bg_gameplay'  # 768x500
        @bg_btn.fixedToCamera = true
        @bg_btn.alpha = 0
        @bg_btn.inputEnabled = on
        @bg_btn.bringToTop()

        ###
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
    # handle last sea to get column inside sea
    # used for drawing a column
    #  & destroy to have column beside sea
    #.----------.----------

   # draw_last_sea : -> # not used
       # @sea1   = @gm.add.sprite 0, @glob.sea.y01 , 'sea1'  # 768x39
        #@sea1.fixedToCamera = true
        #@sea1_tween = @gm.add.tween (@sea1)
        #@sea1_tween.to( {  y:[@glob.sea.y01 + 5, @glob.sea.y01] }, 1600, Phaser.Easing.Linear.None, true, 0, -1 )


    destroy_last_sea : -> @sea1.destroy()

    #.----------.----------
    # fit sea.x with cam
    #.----------.----------
    move_with_cam:(camx)->

        @glob.cloud.dx += @glob.cloud.vx
        if  @glob.cloud.dx > @glob.cloud.lx then  @glob.cloud.vx *= -1
        else if @glob.cloud.dx < 0  then @glob.cloud.vx *= -1

        @sea3.x = camx
        @sea2.x = camx
        if @sea1? then @sea1.x = camx

        @cloud.x = camx + @glob.cloud.dx - @glob.cloud.lx

###



