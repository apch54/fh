
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

        @xtr = {x0:90, y0: 390, r: 20, tta:0, vta: .005 }

        @draw_bg()
        @extra_lily()
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

    #.----------.----------
    #extra liliy
    #.----------.----------
    extra_lily: ->
        @extra_ll = @gm.add.sprite @xtr.x0,@xtr.y0 , "ellipse"
        @extra_ll.scale.setTo .7,.7
        @extra_ll.alpha =.75
        @extra_ll.anchor.setTo  .5, 1

    move_extra:(cam)->
        @xtr.tta += @xtr.vta
        xx = 1.5* @xtr.r * Math.cos @xtr.tta
        yy = -Math.abs @xtr.r * Math.sin @xtr.tta
        #console.log "- #{@_fle_} : ",@gm.camera.x
        @extra_ll.x  = @xtr.x0 + xx + @gm.camera.x
        @extra_ll.y  = @xtr.y0 + yy + @gm.camera.y






