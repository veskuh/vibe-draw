# Simple Draw App

This is a vibe coded (Gemini assisted) simple draw app for Mac. Just a toy project to learn more about Vibe coding.

## Releases

Find the latest release candidates on the releases.

**Heads up:** For this toy project, the application images are **not signed**. Because, frankly, it's a toy project.

## Running the Application (Because Apple Doesn't Like Nice Things)

Running unsigned binaries on macOS can be a bit of a pain, thanks to Gatekeeper. Here's how to get this little app going:

1.  **Grab the `.dmg`:** Download the latest `.dmg` file 
2.  **Mount the `.dmg`:** Double-click the downloaded `.dmg` file to open it.
3.  **Copy the app:** Drag `draw.app` from the mounted volume into your Applications folder (or wherever you prefer), or simply via command line:

    ```bash
    cp /Volumes/draw/draw.app ~/Applications/
    ```

4.  **Remove the stupid quarantine:** macOS slaps a quarantine attribute on downloaded files. You need to get rid of it, or Gatekeeper will keep complaining.

    ```bash
    xattr -d com.apple.quarantine ~/Applications/draw.app
    ```

5.  **Launch the application:** And just like that, it should work!

    ```bash
    open ~/Applications/draw.app
    ```

This whole thing is a quick demo of what an LLM can whip up in about one day of prompting. 