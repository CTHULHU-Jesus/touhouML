mod Lib;
use anyhow::{anyhow, Result};
use enigo::*;
use std::{thread, time};
use x11_screenshot::Screen;
const DELAY: time::Duration = time::Duration::from_secs(10);

fn main() -> Result<()> {
    // Wait for touhou to render
    thread::sleep(DELAY);
    let mut en = Enigo::new();
    let mut cap = Screen::open().ok_or(anyhow!("Screen unable to open"))?;
    let mut state = Lib::TouhouState::State::new()?;

    state.move_to_play(&mut en, &mut cap, None, None, None)?;
    Ok(())
}
