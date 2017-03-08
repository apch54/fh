
class Phacker.Game.Waterlilies

    constructor: (@gm) ->
        @_fle_              = 'Waterlilies'
        @glob               = @gm.ge.parameters
        @glob.wly  =
            x0: if @gm.gameOptions.fullscreen  then @glob.bg.w - 70 else @glob.bg.w - 250 # for a left jump
            y0: @glob.bg.h + 20
            h0: 3
            scale0: .65 #scale
            dxmax: 275  # maximum waterlily dx
            dymax: 162
            way: 'left'

        @left_or_right = ['left', 'right']
        @wls = []
        @make_lily()
        @make_lily()
        @make_lily()

    #.----------.----------
    # make a waterlily
    #.----------.----------
    make_lily : ->
        if @wls.length  is 0 # 1st lily
            @wls.push new Phacker.Game.One_waterlily(@gm,{h: @glob.wly.h0, x:@glob.bg.middleX, y:@glob.wly.y0, scale:@glob.wly.scale0, init: true, way: 'left'})
        else if @wls.length  is 1 # 2nd lily
            @wls.push new Phacker.Game.One_waterlily(@gm,{h: @glob.wly.h0, x:@glob.bg.middleX - 120 , y:@glob.wly.y0 -  71, scale:@glob.wly.scale0, init: true, way: 'left'})
        else
            x0 = @wls[1].position.bottom.x
            y0 = @wls[1].position.bottom.y
            hxys = @hxy_scale  x0,  y0
            @wls.push new Phacker.Game.One_waterlily(@gm, hxys )

        if @spt? then @spt.bringToTop() # sprite at the top layer

    #.----------.----------
    # determine height,x,....
    #.----------.----------
    hxy_scale:(x0, y0)->

        wway = @left_or_right[@gm.rnd.integerInRange(0,1)]
        wway = 'right'

        dx = @gm.rnd.integerInRange 0, 2
        dx = (3 + dx)* @glob.wly.dxmax / 7
        x  = if wway is 'left' then  x0 - dx else  x0 + dx
        y  = y0 - @glob.wly.dymax / @glob.wly.dxmax * dx

        return { h:3, x:x, y:y, scale:@glob.wly.scale0, way:wway } # s is scale

    #.----------.----------
    # add_destroy lilies
    #.----------.----------
    add_destroy: (spt)->

        w = @wls[0]
        if w.position.top.y - spt.y > 80 # 80 is pxl number  :  is waterlilie  80 pxl beneath sprite?
           w.wl.destroy()
           @wls.splice 0, 1
           @make_lily()

        #console.log "- #{@_fle_} : ",spt.y - @wls[2].position.bottom.y, spt.y - @wls[1].position.bottom.y
        if (spt.y - @wls[2].position.bottom.y) < 70 then @wls[2].finalize() # finalise wly after a jump


    #.----------.----------
    # bind obj with sprite
    bind_spt:(spt)-> @spt = spt
