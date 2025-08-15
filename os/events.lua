-- events.lua
function handle(e)
    local event = e[1]
    if event == "mouse_click" then
        local button, mx, my = e[2], e[3], e[4]
        for _, win in ipairs(window.list) do
            if my == win.y and mx >= win.x and mx <= win.x + win.w - 1 then
                win.dragging = true
                win.dragOffsetX = mx - win.x
                win.dragOffsetY = my - win.y
            end
        end
    elseif event == "mouse_drag" then
        local _, mx, my = e[2], e[3], e[4]
        for _, win in ipairs(window.list) do
            if win.dragging then
                win.x = mx - win.dragOffsetX
                win.y = my - win.dragOffsetY
            end
        end
    elseif event == "mouse_up" then
        for _, win in ipairs(window.list) do
            win.dragging = false
        end
    end
end
