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
    bg_set_mouse_event: -> # not used
        @socleO.bg_btn.events.onInputDown.add @on_mouse_down, @
        @socleO.bg_btn.events.onInputUp.add @on_mouse_up, @

    on_mouse_down: ->
        @glob.mouse.down = true
        @glob.mouse.down_ms = new Date().getTime()
        @glob.mouse.dt = 0
        #console.log "- #{@_fle_} : ",'down', @glob.mouse

    on_mouse_up: ->
        @glob.mouse.down = false
        @glob.mouse.dt = new Date().getTime() - @glob.mouse.down_ms
        if @glob.mouse.dt > @glob.mouse.maxTime then  @glob.mouse.dt = @glob.mouse.maxTime
        # mini 250ms
        @glob.mouse.dt = 4.5 / 7 * @glob.mouse.dt + 250

        @glob.mouse.down_ms = 0

        l = @wls.length
        wly = @wls[l - 2]
        wly.twn_climb.start()
        #console.log "- #{@_fle_} : ",'up', wly

    #.----------.----------
    #  when the mouse is domn then  move spring
    # to connect on update
    #.----------.----------
    when_down: () ->
        #l = @wls.length
        wly = @wls[1]
        if  @glob.mouse.down #and @mouse.down_ms > 0
            wly.hat.bringToTop()
            dt = new Date().getTime() - @glob.mouse.down_ms

            dy = Math.floor(dt / @glob.mouse.maxTime * 50)
            if dy >= 50 then dy= 50
            wly.hat.y = wly.position.top.y + dy



    #.----------.----------
    # reset mouse
    # &  compute duration between click/unclick
    #.----------.----------
    reset: ->
        @glob.mouse =
            x: 0 # coordonates
            y: 0
            down: false
            down_ms: 0 # mouse down
            dt: 0 # interval time between click/unclick
            maxTime: 700 # ms
            min: 150


    # bind mouse with sprite
    bind: (waterliliesO) ->
        @wls = waterliliesO.wls

