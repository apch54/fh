# fc on 2017-02-25
#        __   __
#       /  \ /  \
#      | @) | @) |
#     /           \
#     \ \____  __//
#      \_    ||  /
# ___   /    ||  \  ___
# \   \|     ()   |/  /
#  \   |          |  /
#   \   \  \  /  /  /
#    /   /   \/   \  \
#    UUU  UUU  UUU UUU


class Phacker.Game.Sprite
    # @spt stand for sprite
    # @waterliliisO  stands for waterlily obj

    constructor: (@gm, @waterliliesO) -> # wls is array of waterlily obj
        @_fle_ = 'Sprite'
        @wls = @waterliliesO.wls
        @glob = @gm.ge.parameters

        # spite parameters
        @glob.spt =
            reseting: true
            has_collided: true
            jumping: false
            tooLow: false
            max_height: 700 # set when collide
            w: 72, h: 77
            message: 'not used yet'
            angle: 15

        # jmp parameters
        @mouse = @glob.mouse
        @glob.jmp =
            vy: @glob.wly.dxmax / @glob.wly.dymax  *.45 # velocity on y axis
            vx: .6
            g: 700 # gravity

        @spt = @gm.add.sprite @wls[0].position.top.x, @wls[0].position.top.y  - 20, 'character_sprite', 6 #35x60
        @gm.physics.arcade.enable @spt,Phaser.Physics.ARCADE
        @spt.body.gravity.y = @glob.jmp.g
        @spt.body.setSize(70, 30, 1, 47) # w, h, offset x, offset y
        @spt.scale.setTo .8,.8
        @spt.anchor.setTo(0.5, 1) # anchor in the middle of bottom
        @spt.angle = @glob.spt.angle

        @anim_jump = @spt.animations.add 'jmp', [1, 2, 1, 0, 3], 15, false
        @anim_jump.onComplete.add( @turnJ, @ )

        @anim_down = @spt.animations.add 'dwn', [0, 1, 2, 1, 0], 20, false
        @anim_down.onComplete.add(@turn, @)

        @turn()


    #.----------.----------
    # collide sprite with waterlilies
    #.----------.----------
    collide: (waterlilies) ->
        for wls in waterlilies
            #console.log "- #{@_fle_} : ",wls.flw.flw
            if wls.flw? then @gm.physics.arcade.collide(wls.flw.flw, wls.hat )
            if @gm.physics.arcade.collide(
                @spt, wls.wl
                -> return true
                (spt, wls)-> @when_collide(spt, wls)
                @
            ) then return @glob.spt.message
        return 'nothing'

    #.----------.----------
    # call back when colliding
    #.----------.----------
    when_collide: (spt, wly)->

        if not @glob.spt.has_collided
            spt.bringToTop()
            spt.body.velocity.x = 0 # stop here the sprite

            @waterliliesO.wls[1].scale( @waterliliesO.wls[1].prm.scale )
            @waterliliesO.wls[1].make_flower() if not @waterliliesO.wls[1].flw?
            if @waterliliesO.wls[0].flw? then @waterliliesO.wls[0].flw.twn_escape.start()

            @glob.spt.has_collided = true
            @glob.spt.jumping = false
            @spt.animations.play 'dwn'
            @glob.spt.max_height = spt.y + 10 # if sprite goes under max_height then it loose

            if  wly.key is "ellipse"
                #console.log "- #{@_fle_} : ",wly.flower_visible
                if  -10 < (wly.y - spt.y - wly.body.height) < 10
                    if wly.flower_visible  then @glob.spt.message = "bonus"
                    else    @glob.spt.message = "win"
                    @tween_go_center(wly.x , wly.y - spt.body.height / 2)

                else @glob.spt.message = "loose ellipse"
            else @glob.spt.message = "loose cylinder"

            #console.log "- #{@_fle_} : ",spt.key ,wly.key, wly.y - spt.y - wly.body.height, @glob.spt.message
        else @glob.spt.message = 'nothing'

    #.----------.----------
    # test if mouse's up to jump the sprite
    #.----------.----------
    jump: ->
        if not @mouse.down and @mouse.dt > 0 and not @glob.spt.jumping #and not @is_reseting
            if not @spt.body? then return
            #console.log "- #{@_fle_} : ", @mouse
            #@spt.animations.play 'down'
            @spt.animations.play 'jmp'
            @glob.spt.jumping = true # no jump in jump
            @glob.spt.has_collided = false
            @glob.spt.reseting = false
            @spt.y -= 20
            @spt.body.velocity.y = -@mouse.dt * @glob.jmp.vy #-@mouseO.mouse.dt * @vy
            #console.log "- #{@_fle_} : ",@waterliliesO.wls[1].prm.way
            @spt.body.velocity.x =  if @waterliliesO.wls[1].prm.way is 'left' then -@mouse.dt * @glob.jmp.vx  else @mouse.dt * @glob.jmp.vx#gameOptions.pMaxDx * .75  # @mouseO.mouse.dt * @vy

        @mouse.dt = 0

    #.----------.----------
    # make tween  : go center lily leave
    # @spt tween
    #.----------.----------
    tween_go_center: (x0, y0) ->
        @go_center = @gm.add.tween @spt
        @go_center.to(
            { x: x0, y: y0 }
            200, Phaser.Easing.Cubic.Out, true
        )

    #.----------.----------
    # if sprite too low then loose
    #.----------.----------
    check_height: (spt) ->
        #console.log "- #{@_fle_} : ", spt.body.velocity.y
        if  @glob.spt.tooLow then return 'too low yet'
        if (spt.y > @wls[0].hat.y + 5)  and (spt.body.velocity.y > 5) and not @glob.spt.reseting #@glob.spt.max_height
            #console.log "- #{@_fle_} : ",spt.y , @wls[1].hat.y , spt.body.velocity.y
            @glob.spt.tooLow = true
            #@wls[0].flw.flw.destroy() if @wls[0].flw?
            #@wls[1].flw.flw.destroy() if @wls[1].flw?
            return 'loose'
        else return 'ok'

    #----------.----------
    # turn sprite; depending 'left' or 'right'
    #----------.----------
    turn: () ->
        if  @wls[1].prm.way is 'left' then     @spt.scale.setTo   .8,  .8;    @spt.angle =  @glob.spt.angle
        else                                   @spt.scale.setTo   -.8, .8;    @spt.angle = -@glob.spt.angle

    turnJ: () -> # turn when jumping
        if  @spt.angle > 0 then     @spt.angle =  -@glob.spt.angle
        else                        @spt.angle =   @glob.spt.angle






