
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



