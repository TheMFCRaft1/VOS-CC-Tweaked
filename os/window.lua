-- window.lua
os.loadAPI("/os/gui.lua")

list = {}

function create(x, y, w, h, title)
    return {x = x, y = y, w = w, h = h, title = title, dragging = false}
end

function draw(win)
    -- Fensterrahmen + Titel
    gui.box(win.x, win.y, win.w, win.h, colors.gray)
    gui.box(win.x, win.y, win.w, 1, colors.lightGray)
    gui.text(win.x+1, win.y, win.title, colors.black, colors.lightGray)

    -- Inhalt (falls vorhanden)
    if win.draw then win:draw() end
end

function redrawAll()
    term.setBackgroundColor(colors.black)
    term.clear()
    for _, win in ipairs(list) do
        draw(win)
    end
end
