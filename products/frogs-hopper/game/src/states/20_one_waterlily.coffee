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
        @prm.position = @position
        @prm.has_appeared = false

        @wl = @gm.add.physicsGroup() # waterlily

        @wl.enableBody = true
        @cldr = [] #cylinder or stem (part)
        @hat = ''

        @make_waterlily( @prm.h, @prm.x, @prm.y, @prm.scale ) # stem hight, x0
        @make_tween_appear() # automatic on ce on creation
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
        c.alpha = if @prm.init then 1 else .1
        @position.bottom = {x: x0, y: y0 }

        for foo in [0.. h-2] #draw column center part
            y0 -= @glob.cylinder.h
            c=  @gm.add.sprite x0, y0, "cylinder" #@wl.create x0, y0, "cylinder" # create one element of the column
            @cldr.push c
            c.anchor.setTo  .5, 1
            #c.body.setSize(12, 25, 84, 0)# w, h, offset x, offset y
            #c.body.immovable = true
            c.alpha = if @prm.init then 1 else .1

        y0 -= @glob.cylinder.h - 5 # draw hat comomn
        #console.log "- #{@_fle_} : ",@glob.ellipse.h , s ,y0, s
        @hat = @wl.create x0, y0, "ellipse"
        @hat.body.setSize(60, 25, 60, 75)# w, h, offset x, offset y
        @hat.scale.setTo(scale, scale)
        @hat.anchor.setTo  .5, 1
        @hat.body.immovable = true
        @hat.alpha = if @prm.init then 1 else .1

        @hat.prms = @prms
        @position.top ={ x: @hat.x, y: @hat.y }
        @gm.world.bringToTop(@wl)

    #.----------.----------
    # make tween  : appear and climb for jump
    #.----------.----------
    make_tween_appear:  ->
        y1 = @hat.y
        @appear = @gm.add.tween(@hat).to { y: y1 }, 500, Phaser.Easing.Linear.None


    make_tween_climb:  -> #smooth climb  for hat after jump
        @twn_climb = @gm.add.tween @hat
        @twn_climb.to(
            { y: @position.top.y }
            500, Phaser.Easing.Linear.None
        )
    #.----------.----------
    # finalise wly after a jump
    #.----------.----------
    finalize : () ->
        if not @prm.has_appeared
            @prm.has_appeared = true

            @hat.alpha = 1
            for c in @cldr  then c.alpha = 1
            @appear.start()
            @hat.y += 50

    #.----------.----------
    # destroy yhe whole waterlily
    #.----------.----------
    destroy : () ->
        @wl.destroy()
        for c in @cldr then c.destroy()




