-- gui.lua
function box(x, y, w, h, bg)
    term.setBackgroundColor(bg)
    for i = 0, h-1 do
        term.setCursorPos(x, y + i)
        term.write(string.rep(" ", w))
    end
end

function text(x, y, t, fg, bg)
    term.setTextColor(fg)
    term.setBackgroundColor(bg)
    term.setCursorPos(x, y)
    term.write(t)
end
