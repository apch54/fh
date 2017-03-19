
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

        @xtr = {x0:70, y0: 320, r: 20, tta:0, vta: .005 }
        if @gm.gameOptions.fullscreen then @xtr = { x0: 50, y0: 480, r: 20, tta:0, vta: .005 }

        @draw_bg()
        @extra_lily()

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
        @extra_ll.alpha = if @gm.gameOptions.fullscreen then 0 else .6

        @extra_flw = @gm.add.sprite @xtr.x0  + 10, @xtr.y0 + 10 , "bonus"
        #@extra_flw.alpha =.6

    move_extra:(cam)->
        @xtr.tta += @xtr.vta
        xx = 2* @xtr.r * Math.cos @xtr.tta
        yy = -Math.abs @xtr.r * Math.sin @xtr.tta
        #console.log "- #{@_fle_} : ",@gm.camera.x
        @extra_ll.x  = @xtr.x0 + xx + @gm.camera.x
        @extra_ll.y  = @xtr.y0 + yy + @gm.camera.y

        @extra_flw.x = @extra_ll.x
        @extra_flw.y = @extra_ll.y




