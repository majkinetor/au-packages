#  furmark

---
**Install**: `iwr https://goo.gl/SZ9c3m | iex; cinst-gh furmark`

---

FurMark is a very intensive OpenGL benchmark that uses fur rendering algorithms to measure the performance of the graphics card. Fur rendering is especially adapted to overheat the GPU and that's why FurMark is also a perfect stability and stress test tool (also called GPU burner) for the graphics card.

FurMark requires an OpenGL 2.0 compliant graphics card: NVIDIA GeForce 6 (and higher), AMD/ATI Radeon 9600 (and higher), Intel HD Graphics 2000/3000 or a S3 Graphics Chrome 400 series with the latest graphics drivers.

## Command line

FurMark has a GUI or Graphical User Interface but also offers command line parameters. With command line parameters you can control more precisely how FurMark is launched and most of all you can launch multiple times FurMark with different paramaters and log all results in a single result file. This feature is useful for graphics cards reviews and graphics drivers tests.
That said, let’s see the parameters.

- `/nogui` : does not display the startup GUI.
- `/nomenubar` : does not display the menu bar in windowed mode.
- `/noscore` : does not display the final score box
- `/fullscreen` : starts FurMark in fullscreen mode
- `/width` : specifies the screen width – Default: 1280
- `/height` : specifies the screen height – Default: 1024
- `/msaa` : specifies the MSAA level – Default: 0
- `/run_mode` : specifies the run mode: 1 for benchmark, and 2 for stability test – Default: 1
- `/contest_mode` : 1 to enable the contest mode or 0 to disable it – Default: 0 – Contest mode allows an online score submission.
- `/max_time` : specifies the benchmark max time (run_mode=1) in milliseconds – Default: 60000
- `/max_frames` : specifies the benchmark max number of frames (run_mode=1) – Default: -1 (-1 means that max_frames is not used).
- `/app_process_priority` : specifies FurMark process priority – Default: 32 (NORMAL_PRIORITY_CLASS) – See Win32 API for possible values.
- `/app_cpu_affinity` : specifies FurMark main thread CPU affinity – Default: 1 (first CPU core)
- `/rendering_cpu_affinity`: specifies FurMark rendering thread CPU affinity – Default: 2 (second CPU core).
- `/xtreme_burning` : sets FurMarks in a mode that overburns the GPU…
- `/log_temperature`: writes GPU temperature to file (gpu-temperature.xml). This feature is useful for overclocking. FurMark 1.5.0+
- `/log_score` : writes benchmak’s result to file (FurMark-Score.txt). FurMark 1.5.0+
- `/disable_catalyst_warning` : disable warning message box when Catalyst 8.8+ is detected. See here and here for more information. FurMark 1.5.0+


```bat
@echo off
echo Call Test 1...
call FurMark.exe /width=640 /height=480 /msaa=4 /max_time=60000 
/nogui /nomenubar /noscore /run_mode=1 /log_score 
/disable_catalyst_warning
echo Test 1 complete OK.
echo Call Test 2...
call FurMark.exe /width=1024 /height=768 /msaa=4 /max_time=60000 
/nogui /nomenubar /noscore /run_mode=1 /log_score 
/disable_catalyst_warning
echo Test 2 complete OK.
echo Call Test 3...
call FurMark.exe /width=1280 /height=1024 /msaa=4 /max_time=60000 
/fullscreen /nogui /nomenubar /noscore /run_mode=1 /log_score 
/disable_catalyst_warning
echo Test 3 complete OK.
pause
```

![screenshot](https://github.com/majkinetor/au-packages/blob/master/furmark/screenshot.jpg)
