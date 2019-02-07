#!/usr/bin/env python
import curses
import os
import sys


CONFIG = {
    "title": "Console Radio Player",
    "items": [
                {"title": "Soma.FM",
                 "items": [
                          ]
                },
                {"title": "Digitally Imported",
                 "items": [  {"title": "00s Club Hits", "cmd": "mplayer http://prem2.di.fm:80/00sclubhits?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Ambient", "cmd": "mplayer http://prem2.di.fm:80/ambient?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "[!] Atmospheric Breaks", "cmd": "mplayer http://prem2.di.fm:80/atmosphericbreaks?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Bass & Jackin' House", "cmd": "mplayer http://prem2.di.fm:80/bassnjackinhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Bassline", "cmd": "mplayer http://prem2.di.fm:80/bassline?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Big Beat", "cmd": "mplayer http://prem2.di.fm:80/bigbeat?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "?Big Room House", "cmd": "mplayer http://prem2.di.fm:80/bigroomhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Breaks", "cmd": "mplayer http://prem2.di.fm:80/breaks?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Chill & Tropical House", "cmd": "mplayer http://prem2.di.fm:80/chillntropicalhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "ChillHop", "cmd": "mplayer http://prem2.di.fm:80/chillhop?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Chillout", "cmd": "mplayer http://prem2.di.fm:80/chillout?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Chillout Dreams", "cmd": "mplayer http://prem2.di.fm:80/chilloutdreams?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Chillstep", "cmd": "mplayer http://prem2.di.fm:80/chillstep?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Classic EuroDance", "cmd": "mplayer http://prem2.di.fm:80/classiceurodance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Classic Trance", "cmd": "mplayer http://prem2.di.fm:80/classictrance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Classic Vocal Trance", "cmd": "mplayer http://prem2.di.fm:80/classicvocaltrance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Club Dubstep", "cmd": "mplayer http://prem2.di.fm:80/clubdubstep?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Club Sounds", "cmd": "mplayer http://prem2.di.fm:80/club?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "DJ Mixes", "cmd": "mplayer http://prem2.di.fm:80/djmixes?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Dark DnB", "cmd": "mplayer http://prem2.di.fm:80/darkdnb?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Dark PsyTrance", "cmd": "mplayer http://prem2.di.fm:80/darkpsytrance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Deep House", "cmd": "mplayer http://prem2.di.fm:80/deephouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Deep Nu-Disco", "cmd": "mplayer http://prem2.di.fm:80/deepnudisco?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Deep Tech", "cmd": "mplayer http://prem2.di.fm:80/deeptech?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Detroit House & Techno", "cmd": "mplayer http://prem2.di.fm:80/detroithousentechno?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#?Disco House", "cmd": "mplayer http://prem2.di.fm:80/discohouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#?Downtempo Lounge", "cmd": "mplayer http://prem2.di.fm:80/downtempolounge?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Drum and Bass", "cmd": "mplayer http://prem2.di.fm:80/drumandbass?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Drumstep", "cmd": "mplayer http://prem2.di.fm:80/drumstep?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Dub", "cmd": "mplayer http://prem2.di.fm:80/dub?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Dub Techno", "cmd": "mplayer http://prem2.di.fm:80/dubtechno?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Dubstep", "cmd": "mplayer http://prem2.di.fm:80/dubstep?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#EBM", "cmd": "mplayer http://prem2.di.fm:80/ebm?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#EcLectronica", "cmd": "mplayer http://prem2.di.fm:80/eclectronica?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Electro House", "cmd": "mplayer http://prem2.di.fm:80/electrohouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#?Electro Swing", "cmd": "mplayer http://prem2.di.fm:80/electroswing?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Electronic Pioneers", "cmd": "mplayer http://prem2.di.fm:80/electronicpioneers?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Electronics", "cmd": "mplayer http://prem2.di.fm:80/electronics?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Electropop", "cmd": "mplayer http://prem2.di.fm:80/electropop?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Epic Trance", "cmd": "mplayer http://prem2.di.fm:80/epictrance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "EuroDance", "cmd": "mplayer http://prem2.di.fm:80/eurodance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Funky House", "cmd": "mplayer http://prem2.di.fm:80/funkyhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Future Bass", "cmd": "mplayer http://prem2.di.fm:80/futurebass?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Future Garage", "cmd": "mplayer http://prem2.di.fm:80/futuregarage?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Future Synthpop", "cmd": "mplayer http://prem2.di.fm:80/futuresynthpop?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Gabber", "cmd": "mplayer http://prem2.di.fm:80/gabber?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#?Glitch Hop", "cmd": "mplayer http://prem2.di.fm:80/glitchhop?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Goa-Psy Trance", "cmd": "mplayer http://prem2.di.fm:80/goapsy?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Hands Up", "cmd": "mplayer http://prem2.di.fm:80/handsup?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Hard Dance", "cmd": "mplayer http://prem2.di.fm:80/harddance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Hard Techno", "cmd": "mplayer http://prem2.di.fm:80/hardtechno?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Hardcore", "cmd": "mplayer http://prem2.di.fm:80/hardcore?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Hardstyle", "cmd": "mplayer http://prem2.di.fm:80/hardstyle?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "House", "cmd": "mplayer http://prem2.di.fm:80/house?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "?IDM", "cmd": "mplayer http://prem2.di.fm:80/idm?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#?Indie Beats", "cmd": "mplayer http://prem2.di.fm:80/indiebeats?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Indie Dance", "cmd": "mplayer http://prem2.di.fm:80/indiedance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "?Jazz House", "cmd": "mplayer http://prem2.di.fm:80/jazzhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#?Jungle", "cmd": "mplayer http://prem2.di.fm:80/jungle?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Latin House", "cmd": "mplayer http://prem2.di.fm:80/latinhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Liquid DnB", "cmd": "mplayer http://prem2.di.fm:80/liquiddnb?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Liquid Dubstep", "cmd": "mplayer http://prem2.di.fm:80/liquiddubstep?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Liquid Trap", "cmd": "mplayer http://prem2.di.fm:80/liquidtrap?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Lounge", "cmd": "mplayer http://prem2.di.fm:80/lounge?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Mainstage", "cmd": "mplayer http://prem2.di.fm:80/mainstage?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Melodic Progressive", "cmd": "mplayer http://prem2.di.fm:80/melodicprogressive?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Minimal", "cmd": "mplayer http://prem2.di.fm:80/minimal?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Nightcore", "cmd": "mplayer http://prem2.di.fm:80/nightcore?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Nu Disco", "cmd": "mplayer http://prem2.di.fm:80/nudisco?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Oldschool Acid", "cmd": "mplayer http://prem2.di.fm:80/oldschoolacid?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Oldschool House", "cmd": "mplayer http://prem2.di.fm:80/oldschoolhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Oldschool Rave", "cmd": "mplayer http://prem2.di.fm:80/oldschoolrave?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Oldschool Techno & Trance", "cmd": "mplayer http://prem2.di.fm:80/classicelectronica?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Progressive", "cmd": "mplayer http://prem2.di.fm:80/progressive?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Progressive Psy", "cmd": "mplayer http://prem2.di.fm:80/progressivepsy?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "PsyChill", "cmd": "mplayer http://prem2.di.fm:80/psychill?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Psybient", "cmd": "mplayer http://prem2.di.fm:80/psybient?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "?Russian Club Hits", "cmd": "mplayer http://prem2.di.fm:80/russianclubhits?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "?Soulful House", "cmd": "mplayer http://prem2.di.fm:80/soulfulhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Space Dreams", "cmd": "mplayer http://prem2.di.fm:80/spacemusic?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Tech House", "cmd": "mplayer http://prem2.di.fm:80/techhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Techno", "cmd": "mplayer http://prem2.di.fm:80/techno?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Trance", "cmd": "mplayer http://prem2.di.fm:80/trance?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Trap", "cmd": "mplayer http://prem2.di.fm:80/trap?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Tribal House", "cmd": "mplayer http://prem2.di.fm:80/tribalhouse?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "?UMF Radio", "cmd": "mplayer http://prem2.di.fm:80/umfradio?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Underground Techno", "cmd": "mplayer http://prem2.di.fm:80/undergroundtechno?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "?Vocal Chillout", "cmd": "mplayer http://prem2.di.fm:80/vocalchillout?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "#Vocal Lounge", "cmd": "mplayer http://prem2.di.fm:80/vocallounge?${DIGITALLY_IMPORTED_RADIO_KEY}"},
                             {"title": "Vocal Trance", "cmd": "mplayer http://prem2.di.fm:80/vocaltrance?${DIGITALLY_IMPORTED_RADIO_KEY}"}
                          ]
                }
            ]
}


class CursesBase(object):
    def __init__(self, bg_color=curses.COLOR_BLACK, fg_color=curses.COLOR_WHITE):
        self._start_curses()
        
    def _start_curses(self):
        self.screen = curses.initscr()
        curses.noecho()
        curses.cbreak()
        self.screen.keypad(1)
        self.screen_height, self.screen_width = self.screen.getmaxyx()
        curses.start_color()
        self.screen.clear()
        #curses.init_pair(1, bg_color, fg_color)

    def _end_curses(self):
        curses.nocbreak()
        self.screen.keypad(0)
        curses.echo()
        curses.endwin()
 
    def __enter__(self):
        return self

    def __exit__(self,a,b,c):
        self._end_curses()

class CursesMenu(CursesBase):
    KEY_ENTER = 10
    KEY_ESCAPE = 27
    KEY_BS = 127
    EXIT_CODE = 0xFFFF - 1
    EXIT_SYSTEM_CODE = 0xFFFF

    def __init__(self, settings):
        super(CursesMenu, self).__init__(None, None)
        self.settings = settings
        self.style_selected = curses.A_REVERSE
        self.style_regular = curses.A_NORMAL
        self.border_main_size = 2
        self.border_item_size = 2
        title = self.settings.get('title') or self.__class__.__name__
        os.environ['PROMPT_COMMAND'] = 'echo -ne "\\033]0;{0}\\007"'.format(title)

    def _item_str(self, idx, text, total_count):
        idx_str = str(idx).rjust(len(str(total_count))) + ' - '
        return '{0}{1}'.format(idx_str, text.ljust(self.screen_width - 2 * self.border_main_size - 2 * self.border_item_size - len(idx_str), ' '))

    def _get_items_from_menu(self, menu):
        items = []
        for item in (menu.get('items') or []):
            if not (item.get('title') or '').startswith('#'):
                items.append(item)
        return items

    def _show_menu(self, menu, parent, selected_idx=0):
        pos = selected_idx if selected_idx > 0 else 0
        oldpos = None
        key = None
        items = self._get_items_from_menu(menu)
        items_len = len(items)
        if items_len > (self.screen_height - 4):
            items_len = self.screen_height - 4
        if pos > items_len:
            pos = items_len

        while key != CursesMenu.KEY_ENTER:
            if pos != oldpos:
                oldpos = pos
                self.screen.border(0)
                if parent:
                    title = '{0}: {1}'.format(parent['title'], menu['title'])
                else:
                    title = menu['title']
                self.screen.addstr(1,self.border_main_size, title, curses.A_BOLD)

                for i in range(items_len):
                    style = self.style_selected if pos == i else self.style_regular
                    if not items[i]['title'].startswith('#'):
                        text = self._item_str(i + 1, items[i]['title'], items_len)
                        self.screen.addstr(i + 2, self.border_main_size + self.border_item_size, text, style)
                style = self.style_selected if pos == items_len else self.style_regular
                text =  self._item_str('<', 'Back' if parent else 'Exit', items_len)
                self.screen.addstr(2 + items_len, self.border_main_size + self.border_item_size, text, style)
                self.screen.refresh
        
            key = self.screen.getch()
            os.system('echo "Pressed: {0}" >> /tmp/key.log'.format(key))
            if key == curses.KEY_DOWN:
                pos = (pos + 1) if pos < items_len else 0
            elif key == curses.KEY_UP:
                pos = (pos - 1) if pos > 0 else items_len
            elif key == curses.KEY_RIGHT:
                key = CursesMenu.KEY_ENTER
            elif key in [curses.KEY_LEFT, CursesMenu.KEY_BS, ord('q'), ord('Q')]:
                pos = CursesMenu.EXIT_CODE
                break
            elif key == CursesMenu.KEY_ESCAPE:
                pos = CursesMenu.EXIT_SYSTEM_CODE
                break

        if pos == items_len:
            pos = CursesMenu.EXIT_CODE

        return pos

    def process(self, menu=None, parent=None):
        if menu is None:
            menu = self.settings
        print('Menu = {0}'.format(menu))
        items = self._get_items_from_menu(menu)
        items_len = len(items)
        is_exit = False
        menu_idx = 0

        while not is_exit:
            menu_idx = self._show_menu(menu, parent, menu_idx)
            if menu_idx == items_len or menu_idx == CursesMenu.EXIT_CODE \
                or (menu_idx < items_len and items[menu_idx].get('exit')):
                return CursesMenu.EXIT_CODE
            elif menu_idx == CursesMenu.EXIT_SYSTEM_CODE:
                return CursesMenu.EXIT_SYSTEM_CODE
            elif items[menu_idx].get('cmd'):
                self._end_curses()
                cmd = items[menu_idx].get('cmd')
                title = items[menu_idx].get('title') or 'unknown'
                os.system('echo {0}'.format('='*75))
                os.system('echo "    Run: {0}"'.format(title))
                os.system('echo "Command: {0}"'.format(cmd))
                os.system('echo {0}'.format('='*75))
                result_code = os.system(cmd)
                if result_code != 0:
                    self.screen.getch()
                self._start_curses()
                #self.screen.clear()
                #return menu_idx
            elif items[menu_idx].get('items'):
                self.screen.clear()
                code = self.process(items[menu_idx], menu)
                self.screen.clear()
                if code == CursesMenu.EXIT_SYSTEM_CODE:
                    return CursesMenu.EXIT_SYSTEM_CODE

if __name__ == '__main__':
    with CursesMenu(CONFIG) as menu:
        code = menu.process()
    sys.exit(code)

