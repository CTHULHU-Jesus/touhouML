use anyhow::Result;
pub mod TouhouState {
    // IMPORT
    use anyhow::{anyhow, Result};
    use enigo::*;
    use image::*;
    use x11_screenshot::Screen;

    // TYPES
    #[derive(Clone)]
    pub enum State {
        OptionMenu(),
        MainMenu(),
        DifSelect(Difficulty),
        CharSelect(Character),
        BombSelect(Bomb),
        Playing(GameState),
        GameOver(),
    }

    #[derive(Copy, Clone, Debug)]
    pub enum Difficulty {
        Easy,
        Normal,
        Hard,
        Lunatic,
    }

    #[derive(Copy, Clone, Debug)]
    pub enum Character {
        Reimu,
        Marisa,
    }

    #[derive(Copy, Clone, Debug)]
    pub enum Bomb {
        One,
        Two,
    }

    #[derive(Copy, Clone, Debug)]
    pub struct GameState {
        pub score: i32,
        pub lives: i32,
        pub bombs: i32,
    }

    // IMPLEMENTS
    impl Default for GameState {
        fn default() -> Self {
            GameState {
                score: 0,
                lives: 1,
                bombs: 1,
            }
        }
    }
    impl State {
        pub fn new() -> Result<State> {
            // Return
            Ok(State::OptionMenu())
        }

        pub fn move_to_play(
            &mut self,
            mut en: &mut Enigo,
            mut cap: &mut Screen,
            d: Option<Difficulty>,
            c: Option<Character>,
            b: Option<Bomb>,
        ) -> Result<()> {
            use State::*;
            // Until we get to the game continue to transition through states
            while match self {
                Playing(_) => false,
                _ => true,
            } {
                self.transition(&mut en, &mut cap, d, c, b)?;
            }
            Ok(())
        }

        fn transition(
            &mut self,
            mut en: &mut Enigo,
            mut cap: &mut Screen,
            d: Option<Difficulty>,
            c: Option<Character>,
            b: Option<Bomb>,
        ) -> Result<()> {
            use State::*;
            let s: State = self.clone();
            fn screen_shot(mut cap: &mut Screen, s: String) -> Result<()> {
                if cfg!(debug_assertions) {
                    take_screen_shot(&mut cap, s)?;
                };
                Ok(())
            }
            fn menuing_delay() {
                use std::{thread, time};
                const DELAY: time::Duration = time::Duration::from_millis(2 * 12000);
                thread::sleep(DELAY);
            }
            match self {
                OptionMenu() => {
                    menuing_delay();
                    screen_shot(cap, "/outside/Options_menu.png".to_string())?;
                    // enter to move from options menu
                    en.key_click(Key::Return);
                    *self = MainMenu();
                }
                MainMenu() => {
                    menuing_delay();
                    screen_shot(cap, "/outside/Main_menu.png".to_string());
                    en.key_click(Key::Return);
                    *self = DifSelect(d.unwrap_or(Difficulty::Easy));
                }
                DifSelect(d) => {
                    menuing_delay();
                    screen_shot(cap, "/outside/Difficulty_select.png".to_string());
                    en.key_click(Key::Return);
                    *self = Playing(GameState::default());
                    //CharSelect(c.or(Character::Reimu));
                }
                CharSelect(c) => {}
                BombSelect(b) => {}
                Playing(GameState) => {}
                GameOver() => {}
            };
            Ok(())
        }
    }

    // FUNCTIONS
    pub fn get_frame(cap: &mut Screen) -> Result<RgbImage> {
        cap.capture().ok_or(anyhow!("Unable to capture frame"))
    }
    pub fn take_screen_shot<P>(cap: &mut Screen, p: P) -> Result<()>
    where
        P: AsRef<std::path::Path>,
    {
        get_frame(cap)?.save(p)?;
        Ok(())
    }
}

pub fn set_correct_options() -> Result<()> {
    Ok(())
}
