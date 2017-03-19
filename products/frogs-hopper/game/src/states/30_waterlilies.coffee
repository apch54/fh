
class Phacker.Game.Waterlilies

    constructor: (@gm) ->
        @_fle_              = 'Waterlilies'
        @glob               = @gm.ge.parameters
        @glob.wly  =
            x0: if @gm.gameOptions.fullscreen  then @glob.bg.w - 70 else @glob.bg.w - 250 # for a left jump
            y0: @glob.bg.h + 20
            h0: 3
            scale0: .75 #scale
            dxmax: 275  # maximum waterlily dx
            dymax: 162
            tan: 162 / 275
            way: 'left'

        @scale_a = [@glob.wly.scale0, .67, .60, .53]

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
            @wls.push new Phacker.Game.One_waterlily(@gm,{h: @glob.wly.h0, x:@glob.bg.middleX, y:@glob.wly.y0, scale:@glob.wly.scale0, init: 0, way: 'left'})
        else if @wls.length  is 1 # 2nd lily
            @wls.push new Phacker.Game.One_waterlily(@gm,{h: @glob.wly.h0, x:@glob.bg.middleX - 130 , y:@glob.wly.y0 - 77, scale:@glob.wly.scale0, init: 1, way: 'left'})
            @wls[1].make_flower()
        else
            x0 = @wls[1].position.bottom.x
            y0 = @wls[1].position.bottom.y
            hxys = @hxy_scale  x0,  y0 # compute h (stems), x, y & scale
            @wls.push new Phacker.Game.One_waterlily(@gm, hxys )

        if @spt? then @spt.bringToTop() # sprite at the top layer

    #.----------.----------
    # determine height,x,y,scale :  4 phases
    # 1/ < 50  no variations
    # 2/ < 100  scale variation
    # 3/ var dx, dy  & scale
    # 4/ var h (stem), dx, dy  & scale
    # .----------.----------
    hxy_scale:(x0, y0)->

        wway = @left_or_right[@gm.rnd.integerInRange(0,1)]
        #wway = 'right'

        # 1/ < 50  no variation
        if @gm.ge.score < 50
            hh = @glob.wly.h0
            xx = if wway is "left" then x0 - 130 else x0 + 130
            yy = y0 - 77
            scl = @glob.wly.scale0

        # 2/  100  scale variations
        else if @gm.ge.score < 100
            hh = @glob.wly.h0
            xx = if wway is "left" then x0 - 130 else x0 + 130
            yy = y0 - 77
            scl =  @scale_a[@gm.rnd.integerInRange(0, 3 )] # between .7 to .55

        # 3/ var dx, dy  & scale
        else if @gm.ge.score < 150
            if @wls[0].prm.way is wway then  dx = @gm.rnd.integerInRange 1, 3
            else dx = @gm.rnd.integerInRange 2, 2

            hh = @glob.wly.h0
            dx = (3 + dx) * @glob.wly.dxmax / 8
            xx  = if wway is 'left' then  x0 - dx else  x0 + dx
            yy  = y0 - @glob.wly.tan * dx
            scl =  @scale_a[@gm.rnd.integerInRange(0, 3 )] # between .7 to .55

        # 4/ var h (stem), dx, dy  & scale
        else
            if @wls[0].prm.way is wway then  dx = @gm.rnd.integerInRange 1, 3
            else dx = @gm.rnd.integerInRange 2, 2

            hh = @gm.rnd.integerInRange 2, 4
            dx = (3 + dx) * @glob.wly.dxmax / 8
            xx  = if wway is 'left' then  x0 - dx else  x0 + dx
            yy  = y0 - @glob.wly.tan * dx
            scl =  @scale_a[@gm.rnd.integerInRange(0, 3 )]

        return { h:hh, x:xx, y:yy, scale: scl, way: wway } # way is left or right

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
