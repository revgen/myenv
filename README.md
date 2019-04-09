```
   ███┐   ███┐ ██┐   ██┐ ███████┐ ███┐   ██┐ ██┐   ██┐
   ████┐ ████│ └██┐ ██┌┘ ██┌────┘ ████┐  ██│ ██│   ██│
   ██┌████┌██│  └████┌┘  █████┐   ██┌██┐ ██│ ██│   ██│
   ██│└██┌┘██│   └██┌┘   ██┌──┘   ██│└██┐██│ └██┐ ██┌┘
   ██│ └─┘ ██│    ██│    ███████┐ ██│ └████│  └████┌┘
   └─┘     └─┘    └─┘    └──────┘ └─┘  └───┘   └───┘
```

My scripts, tools and settings for everyday use.


## Installation

Installation script support OS X and Linux system.

When you need an environment only you can download [install.sh] script and execute it.

Terminal command using **wget**:
```bash
$ wget -qO- https://raw.githubusercontent.com/revgen/myenv/master/install.sh | bash
```

Terminal command using **curl**:
```bash
$ curl -L https://raw.githubusercontent.com/revgen/myenv/master/install.sh | bash
```

When you need an ability to make a changes in the repository:
```bash
$ git clone https://github.com/revgen/myenv.git ~/.local/var/myenv
$ bash ~/.local/var/myenv/install.sh
```

## Settings

* [MacOS - Settings](https://github.com/revgen/myenv/tree/master/setup/macos#os-x-settings-tools-and-applications)
* [Linux - Settings](https://github.com/revgen/myenv/tree/master/setup/linux#linux-settings-tools-and-applications)
* [Windows - Settings](https://github.com/revgen/myenv/tree/master/setup/windows#windows-core-tools)


## Themes, fonts and colors 

### Colors

| Sample |  Html  |      RGB     | Description        |
|:--:|:-----:|:------------:|:-------------------|
|![#191919][color-191919]|#191919|(025,025,025) | Background color   |
|![#283C50][color-283C50]|#283C50|(040,060,080) | Background color   |
|![#619647][color-619647]|#619647|(038,059,028) | Text green color   |


### Themes

* Vim: [Dracula theme](https://github.com/dracula/vim/tree/master/colors)
* IntelliJ: [Darcula theme](http://www.eclipsecolorthemes.org/?view=theme&id=14569)


[install.sh]: https://raw.githubusercontent.com/revgen/myenv/master/install.sh
[color-191919]: http://dummyimage.com/32x32/191919/191919.png
[color-283C50]: http://dummyimage.com/32x32/283C50/283C50.png
[color-619647]: http://dummyimage.com/32x32/619647/619647.png

