# fc 2017-03-02
#             __.--,.,--.__
#           .(  './   \.'  ).
#          ;__\   \   /   /__;
#         (   `',-:"o"o-,'`   )
#         /'.__/o'o.'o'o.\__.'\
#         \.-' \o'.o.'o'o/ '-./
#         (     ;-o.:o.-;     )
#          ;--'/    |    \'--;
#           `-.\   /^\   /.-'
#               `"`---`"`
class Phacker.Game.One_waterlily

    constructor: (@gm, @prm) -> #prm = {h:, x:, y:, scale:, way}
        @_fle_          = 'One waterlily'
        @glob = @gm.ge.parameters

        #Column parameters
        @glob.cylinder     =  { w:  10, h: 25 }  # cylinder size
        @glob.ellipse      =  { w: 160, h: 80 }  # ellipse

        @position = {top:{x:0, y:0}, bottom:{x:0,y:0}}
        #@prm.position = @position
        @has_appeared = false

        @wl = @gm.add.physicsGroup() # waterlily

        @wl.enableBody = true
        @cldr = [] #cylinder or stem (part)
        @hat = ''

        @make_waterlily( @prm.h, @prm.x, @prm.y, @prm.scale ) # stem hight, x0
        #@make_tween_appear() # automatic on ce on creation
        @make_tween_climb()  # must be started


    #.----------.----------
    #make the waterlily
    #.----------.----------

    make_waterlily:(h, x0, y0, scale)-> # number of stem, x location & scale

        #h must be > 2
        c = @gm.add.sprite x0, y0, "cylinder" #@wl.create x0, y0, "cylinder"
        @cldr.push c
        c.anchor.setTo  .5, 1
        #c.body.setSize(12, 25, 84, 0)# w, h, offset x, offset y
        #c.body.immovable = true
        c.alpha = if @prm.init < 2 then 1 else .1
        @position.bottom = {x: x0, y: y0 }

        for foo in [0.. h-2] #draw column center part
            y0 -= @glob.cylinder.h
            c=  @gm.add.sprite x0, y0, "cylinder" #@wl.create x0, y0, "cylinder" # create one element of the column
            @cldr.push c
            c.anchor.setTo  .5, 1
            #c.body.setSize(12, 25, 84, 0)# w, h, offset x, offset y
            #c.body.immovable = true
            c.alpha = if @prm.init < 2 then 1 else .1

        y0 -= @glob.cylinder.h - 5 # draw hat comomn
        #console.log "- #{@_fle_} : ",@glob.ellipse.h , s ,y0, s
        @hat = @wl.create x0, y0, "ellipse"
        @hat.body.setSize(60, 25, 60, 75)# w, h, offset x, offset y
        @hat.scale.setTo(scale, scale)
        @hat.anchor.setTo  .5, 1
        @hat.body.immovable = true
        @hat.alpha = if @prm.init < 2 then 1 else .1

        @hat.prms = @prms
        @position.top ={ x: @hat.x, y: @hat.y }
        @gm.world.bringToTop(@wl)


    #----------.----------
    # make a flower
    #----------.----------
    make_flower: () ->
        @flw = new Phacker.Game.Flower(@gm, {x0:@position.top.x, y0:@position.top.y, way: @prm.way } )
    #.----------.----------
    # make tween  : appear and climb for jump
    #.----------.----------
    make_tween_appear:  ->
        y1 = @hat.y
        @appear = @gm.add.tween(@hat).to { y: y1 }, 500, Phaser.Easing.Linear.None


    make_tween_climb:  -> #smooth climb  for hat after jump
        @twn_climb = @gm.add.tween @hat
        @twn_climb.to(
            { y: "+15" }
            150, Phaser.Easing.Linear.None
        )
        @twn_climb.onComplete.addOnce(
          ->
              e = @gm.add.tween(@hat);
              e.to({ y: "-15" }, 150, Phaser.Easing.Linear.None)
              e.start()
          this
        )
    #.----------.----------
    # finalise wly after a jump
    #.----------.----------
    finalize : (dx) ->

        #@hat.alpha = 1
        sc = @prm.scale * (1.3333 - dx /  75)
        @scale sc
        #@hat.y += 50

    #----------.----------
    # scasle the entire waterlily
    #----------.----------
    scale: (scl) ->
        for n  in [0..@cldr.length - 1]
            stem = @cldr[n]

            y = @prm.y - n * @glob.cylinder.h * scl
            stem.y = y
            stem.scale.setTo scl, scl

        y -=  @glob.cylinder.h * scl
        @hat.y = y
        @hat.scale.setTo scl, scl

        @position.top.y = y
        #@prm.scale = scl

    #----------.----------
    # alpha the entire waterlily
    #----------.----------
    alpha: (a) ->
        for n  in [0..@cldr.length - 1] then  @cldr[n].alpha = a
        @hat.alpha = a

    #----------.----------
    # move the waterlily
    #----------.----------
    moveTo: (x, y) ->
        for n  in [0..@cldr.length - 1]
            stem = @cldr[n]

            yy = y - n * @cylinder.h * @prm.scale
            stem.y = yy;        stem.x = x
            @bottom.x = x;      @bottom.y = y

        yy -=  @cylinder.h * @prm.scale
        @hat.x = x;         @hat.y = yy
        @top.x = x;         @top.y = yy -  @hat.body.height * @prm.scale # ok


    #.----------.----------
    # destroy yhe whole waterlily
    #.----------.----------
    destroy : () ->
        @wl.destroy()  # destroy leaf
        for c in @cldr then c.destroy() # destry stem
        @flw.flw.destroy() if flw?




