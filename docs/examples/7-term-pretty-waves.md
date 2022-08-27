---
layout: default
title: Terminal Pretty Waves Example
---

# {{ page.title }}
```the
obj Point {
  x: int
  y: int
}

HEIGHT := 47
WIDTH := 97
HEIGHT_DIV2 := HEIGHT / 2
WIDTH_DIV2 := WIDTH / 2
REFRESH_RATE := 30
SLEEP_INTERVAL: u64 = 1000 / REFRESH_RATE

COLOR_CODES := [40, 41, 42, 43, 44, 45, 46, 47]
CLEAR_SCREEN_CODE := "\033[" + HEIGHT.str() + "A"
RESET_CODE := "\033[0m"

main {
  mut prevColorIdx := 0
  mut curColorIdx := 1
  mut circleRadius := 1

  mut centerPoint := Point{
    x: WIDTH_DIV2 - circleRadius,
    y: HEIGHT_DIV2 - circleRadius
  }

  loop frame := 0;; frame++ {
    if circleRadius == HEIGHT + HEIGHT / 2 {
      circleRadius = 1
      prevColorIdx = curColorIdx
      curColorIdx = (curColorIdx == COLOR_CODES.len - 1) ? 0 : curColorIdx + 1
    } else {
      circleRadius++
    }

    centerPoint.x = WIDTH_DIV2 - circleRadius
    centerPoint.y = HEIGHT_DIV2 - circleRadius

    mut result := ""

    loop i := 0; i < HEIGHT; i++ {
      loop j := 0; j < WIDTH; j++ {
        mut colorCode: int = COLOR_CODES[prevColorIdx]
        x := j - circleRadius - centerPoint.x
        y := (i - circleRadius - centerPoint.y) * 2

        if x * x + y * y <= circleRadius * circleRadius + 1 {
          colorCode = COLOR_CODES[curColorIdx]
        }

        result += "\033[1;" + colorCode.str() + "m "
      }

      result += i == 0 ? "" : "\n"
    }

    result += RESET_CODE

    if frame != 0 {
      print(CLEAR_SCREEN_CODE, terminator: "")
    }

    print(result, terminator: "")
    sleep(SLEEP_INTERVAL)
  }
}
```