# fc on 2017-02-01

class Phacker.Game.My_mouse

    constructor: (@gm, @socleO) ->
        @_fle_ = 'Mouse'
        @glob = @gm.ge.parameters
        @reset()
        @bg_set_mouse_event()

    #.----------.----------
    # mouse init & pointer follow mouse
    #.----------.----------
    bg_set_mouse_event: ->
         #@socleO.bg_btn.events.onInputDown.add @on_mouse_down, @
         #@socleO.bg_btn.events.onInputUp.add @on_mouse_up, @
         @gm.input.onDown.add @on_mouse_down, @
         @gm.input.onUp.add @on_mouse_up, @

    on_mouse_down: ->
        if not @spriteO?  and @spriteO.glob.spt.jumping then return
        @glob.mouse.down = true
        @glob.mouse.down_ms = new Date().getTime()
        @glob.mouse.dt = 0
        #console.log "- #{@_fle_} : ",'down', @glob.mouse

    on_mouse_up: ->
        if  not @glob.mouse.down then return
        if not @spriteO?  and @spriteO.glob.spt.jumping then return
        @glob.mouse.down = false
        @glob.mouse.dt = new Date().getTime() - @glob.mouse.down_ms
        if @glob.mouse.dt > @glob.mouse.maxTime then  @glob.mouse.dt = @glob.mouse.maxTime

        if @glob.mouse.dt < 200  then    @glob.mouse.dt = 0 # mini = 200ms
        else   @glob.mouse.dt = 5 / 7 * @glob.mouse.dt + 200

        @glob.mouse.down_ms = 0

        #l = @wls.length
        #wly = @wls[l - 2]
        #wly.twn_climb.start()
        #console.log "- #{@_fle_} : ",'up', wly

    #.----------.----------
    #  when the mouse is domn then  move spring
    # to connect on update
    #.----------.----------
    when_down: () ->
        #l = @wls.length
        if not @spriteO?  and @spriteO.glob.spt.jumping then return
        wly = @wls[0]
        if  @glob.mouse.down #and @mouse.down_ms > 0
            wly.hat.bringToTop()
            dt = new Date().getTime() - @glob.mouse.down_ms
            if dt < 200 then return

            dy = 50 * dt / (@glob.mouse.maxTime - 200 ) - 20
            if dy >= 50 then dy= 50
            wly.hat.y = wly.position.top.y + dy
            if wly.flw? then wly.flw.flw.y = wly.position.top.y + dy - 20

    #.----------.----------
    # reset mouse
    # &  compute duration between click/unclick
    #.----------.----------
    reset: ->
        #console.log "- #{@_fle_} : ",@gm.device.android
        @gm.input.reset()
        @glob.mouse =
            x: 0 # coordonates
            y: 0
            down: false
            down_ms: 0 # mouse down
            dt: 0 # interval time between click/unclick
            maxTime: 700 # ms
            min: 150


    # bind mouse with sprite
    bind: (waterliliesO, spriteO) ->
        @wls = waterliliesO.wls
        @spriteO = spriteO

