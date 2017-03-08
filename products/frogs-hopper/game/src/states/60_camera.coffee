###
    ----------------------
    fc 2017-03-05
    camera
    ----------------------
###

class Phacker.Game.My_camera

    constructor: (@gm, @waterliliesO) ->
        @_fle_          = 'Camera'
        @glob               = @gm.ge.parameters

        @offset     = # left or right offset for camera
            xl: @glob.wly.x0  #offset for left jmp
            xr: if @gm.gameOptions.fullscreen  then 70 else 210
            y: @glob.wly.y0 - 54

        @speed      = 4     # cam speed movement on X & Y

    #.----------.----------
    #move camera on left at speed @speed
    #.----------.----------
    move:(spt)->
        way = @waterliliesO.wls[1].prm.way #{left or right jmp
        #console.log "- #{@_fle_} : ", way

        if  way is 'left'
            if (@gm.camera.x - spt.x + @offset.xl) < -@speed then  @gm.camera.x += @speed
            else @gm.camera.x  = spt.x - @offset.xl
        else
            if ( spt.x - @offset.xr - @gm.camera.x ) > @speed then @gm.camera.x += @speed
            else @gm.camera.x  = spt.x - @offset.xr

        if (@gm.camera.y - spt.y - @offset.y) > @speed then @gm.camera.y -= @speed # for time reseting : not all at once
        else @gm.camera.y  = spt.y - @offset.y
        #console.log "- #{@_fle_} : ",@gm.camera.y, spt.y,  @offset.y


