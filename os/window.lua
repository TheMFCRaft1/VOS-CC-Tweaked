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
-- window.lua (ergänzt)
function draw(win)
    -- Fensterrahmen + Titel
    gui.box(win.x, win.y, win.w, win.h, colors.gray)
    gui.box(win.x, win.y, win.w, 1, colors.lightGray)
    gui.text(win.x+1, win.y, win.title, colors.black, colors.lightGray)

    -- Schließen-Button
    gui.button(win.x + win.w - 3, win.y, 3, 1, "X", function()
        for i, w in ipairs(list) do
            if w == win then table.remove(list, i) end
        end
    end)

    -- Inhalt (falls vorhanden)
    if win.draw then win:draw() end
end
-- /os/window.lua (Taskbar)
function drawTaskbar()
    local w, h = term.getSize()
    gui.box(1, h, w, 1, colors.lightGray)
    for i, win in ipairs(list) do
        gui.button(2 + (i-1)*10, h, 10, 1, win.title, function()
            -- Fenster in den Vordergrund holen
            table.remove(list, i)
            table.insert(list, win)
        end)
    end
end

-- Taskbar in redrawAll aufrufen
function redrawAll()
    term.setBackgroundColor(colors.black)
    term.clear()
    for _, win in ipairs(list) do
        draw(win)
    end
    drawTaskbar()
end
