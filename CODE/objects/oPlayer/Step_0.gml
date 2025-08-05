if (!instance_exists(oDialog)) {
    var _up    = keyboard_check(vk_up);
    var _down  = keyboard_check(vk_down);
    var _left  = keyboard_check(vk_left);
    var _right = keyboard_check(vk_right);

    horizontalSpeed = (_right - _left) * moveSpeed;
    verticalSpeed   = (_down  - _up)   * moveSpeed;

    if (place_meeting(x + horizontalSpeed, y, oWall)) horizontalSpeed = 0;
    if (place_meeting(x, y + verticalSpeed, oWall))   verticalSpeed   = 0;
    
    x += horizontalSpeed;
    y += verticalSpeed;
} else {
    horizontalSpeed = 0;
    verticalSpeed   = 0;
}

// — Determine facing direction —
if (horizontalSpeed != 0 || verticalSpeed != 0) {
    if (abs(horizontalSpeed) > abs(verticalSpeed)) {
        dir = (horizontalSpeed > 0) ? 1 : 3;
    } else {
        dir = (verticalSpeed < 0) ? 0 : 2;
    }
}

// — Animation handling —
var moving = (horizontalSpeed != 0) || (verticalSpeed != 0);
var base   = dir * 3;  // start index for current direction

if (moving) {
    anim_timer += 1;
    if (anim_timer >= anim_speed) {
        anim_timer = 0;
        // wrap within the 3-frame block
        if (image_index < base || image_index >= base + 3) {
            image_index = base;
        } else {
            image_index = base + ((image_index - base + 1) mod 3);
        }
    }
} else {
    // reset to idle frame
    anim_timer  = 0;
    image_index = base;
}