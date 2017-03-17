
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
            tan: 162 / 275
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
            @wls[1].make_flower()
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
        #wway = 'right'

        # @wls[2] is right over @wls[0] so put it a little far away
        if @wls[0].prm.way is wway then  dx = @gm.rnd.integerInRange 1, 2
        else dx = @gm.rnd.integerInRange 2, 2

        dx = (3 + dx)* @glob.wly.dxmax / 8
        x  = if wway is 'left' then  x0 - dx else  x0 + dx
        y  = y0 - @glob.wly.tan * dx

        return { h:3, x:x, y:y, scale:@glob.wly.scale0, way: wway } # s is scale

    #.----------.----------
    # add_destroy lilies
    #.----------.----------
    add_destroy: (spt)->
        #if @wls[2]? then console.log "- #{@_fle_} : ",@wls[0].position.top.y - @wls[0].hat.height - @wls[2].position.bottom.y, @spt.y
        w = @wls[0]
        if w.position.top.y - spt.y > 80 # 80 is pxl number  :  is waterlilie  80 pxl beneath sprite?
           w.destroy()
           @wls.splice 0, 1
           @make_lily()

        # make lily 1 apprear
        dx = spt.y - @wls[2].position.bottom.y
        if  (25 < dx < 100) and spt.body.velocity.y < 0
            @wls[2].alpha 1
            @wls[2].finalize dx # finalise wly after a jump


    #.----------.----------
    # bind obj with sprite
    bind_spt:(spt)-> @spt = spt
