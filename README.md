
# WormHunter 2024
A classic Snake game implemented in Pascal for the terminal. Supports Linux, macOS, and Windows.

## Features
- Play the Snake game in your terminal.
- Simple controls and gameplay.

## Requirements
- Free Pascal Compiler (FPC)

## Installation

### Linux
1. **Install Free Pascal Compiler (FPC)**
    - For Ubuntu:
      ```sh
      sudo apt install fpc
      ```
    - For Fedora:
      ```sh
      sudo dnf install fpc
      ```
    - For Arch:
      ```sh
      sudo pacman -S fpc
      ```

2. **Download and Compile**
    - Go to the directory where `wormhunter.pas` is located:
      ```sh
      cd path/to/your/directory
      ```
    - Compile the game:
      ```sh
      fpc wormhunter.pas
      ```
3. **Run the Game**
    ```sh
    ./wormhunter
    ```

### macOS
1. **Install Homebrew (if not installed)**
    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2. **Install Free Pascal Compiler (FPC) using Homebrew**
    ```sh
    brew install fpc
    ```

3. **Download and Compile**
    - Go to the directory where `wormhunter.pas` is located:
      ```sh
      cd path/to/your/directory
      ```
    - Compile the game:
      ```sh
      fpc wormhunter.pas
      ```

4. **Run the Game**
    ```sh
    ./wormhunter
    ```

### Windows
1. **Download and Install Free Pascal Compiler (FPC)**
    - Download the FPC installer from the [Free Pascal website](https://www.freepascal.org/download.var).
    - Run the installer and follow the on-screen instructions to complete the installation.

2. **Download and Compile**
    - Open Command Prompt and navigate to the directory where `wormhunter.pas` is located:
      ```sh
      cd \path\to\your\directory
      ```
    - Compile the game:
      ```sh
      fpc wormhunter.pas
      ```

3. **Run the Game**
    ```sh
    wormhunter.exe
    ```

## Controls
- **Arrow Keys**: Control the direction of the snake.
- **ESC**: Exit the game.

## Gameplay
- Navigate the snake to eat the food represented by `~`.
- Each time the snake eats food, it grows in length.
- Avoid colliding with the walls and the snake's own body to keep playing.

## Contributing
Contributions are welcome! Please feel free to submit a Pull Request.

## License
This project is licensed under the GNU General Public License. See the [LICENSE](LICENSE) file for details.
