using SFML
#=------------------------------------------------------------------------------
                            Constants
------------------------------------------------------------------------------=#
t = 8*pi/4
a = 0*pi/8
td = 0.1 * rand()
ad = 0.2 * rand()
g = 9.8
δ = 1/90 # delta
#=------------------------------------------------------------------------------
------------------------------------------------------------------------------=#
f₁ = 100
f₂ = 200
Δt = 0.01
sim_time = 10
tₖ = 0:Δt:sim_time
#=------------------------------------------------------------------------------
                            window setup 
------------------------------------------------------------------------------=#
# Setup the window with some anti aliasing
settings = ContextSettings()
settings.antialiasing_level = 3
window = RenderWindow(VideoMode(800, 600), "Rosette test", settings, window_defaultstyle)

# Framerate limit
set_framerate_limit(window, 60)
event = Event()

# Create one circle
#=------------------------------------------------------------------------------
                        create the shapes
------------------------------------------------------------------------------=#
circle = CircleShape()
set_radius(circle, 10)
set_fillcolor(circle, SFML.red)
set_origin(circle, Vector2f(10, 10))

#=------------------------------------------------------------------------------
                        principal loop
------------------------------------------------------------------------------=#
while isopen(window)
    # Check for events
    while pollevent(window, event)
        if(get_type(event) == EventType.CLOSED)
            close(window)
        end
        # Allow the user to control the δ with the left and right arrow keys
        if(get_type(event) == EventType.KEY_PRESSED)
            if(get_key(event).key_code == KeyCode.LEFT)
                δ = -.1
            elseif(get_key(event).key_code == KeyCode.RIGHT)
                δ = .1
            end
        end
    end
    cycles = 5000
#=------------------------------------------------------------------------------
                        Simulate the Rosette                          
                    x(t) = (cos(f₁*t) + cos(f₂*t))
                    y(t) = (sin(f₁*t) - sin(f₂*t))
------------------------------------------------------------------------------=#    
    tdd = 1
    add = 1
    
    for i = 1:cycles
        td += δ * tdd / cycles
        ad += δ * add / cycles
        t  += δ * td / cycles
        a  += δ * ad / cycles
    end
    x = 400 + 100 * (cos(t) + cos(a + t))
    y = 300 + 100 * (sin(t) - sin(a + t))
    # draw the circle
    set_position(circle, Vector2f(x, y))

    # Draw everything
    clear(window, SFML.black)
    draw(window, circle)
    display(window)
end
