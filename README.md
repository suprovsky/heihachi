# Heihachi

A Discord bot to receive Tekken 8 frame data primarily from [Wavu Wiki](https://wavu.wiki/t/Main_Page)

## Instructions

Clone this repository to a Linux server that has Python 3.10.0+ and install the dependencies with:

```bash
git clone https://github.com/TLNBS2405/heihachi
cd heihachi
python3 -m pip install .
```
### Config

The Heihachi bot is configured using a `config.json` file. A sample file is provided in `static/config.sample.json`.

```json
{
    "DISCORD_TOKEN": "YOUR_DISCORD_TOKEN",
    "FEEDBACK_CHANNEL_ID": feedback_channel_id,
    "ACTION_CHANNEL_ID": action_channel_id,
    "BLACKLIST": ["user1", "user2"],
    "ID_BLACKLIST": [0, 1]
}
```
You can obtain your own Discord token by creating a Discord bot ([instructions](https://discordpy.readthedocs.io/en/stable/discord.html)).
The bot must have the "Message Content Intent" enabled on the Discord Developer Portal. The bot uses a permissions integer
of 551903315968 (Send Messages, Embed Links, Use Slash Commands, Use Embedded Activities).

The `FEEDBACK_CHANNEL_ID` is the channel where the bot will send feedback messages. The bot supports the slash command `/feedback <message>` to allow users to provide feedback on the bot's operation or frame data, and have the bot repost it in a dedicated channel for easier tracking.

![Feedback](/assets/feedback_example.png)

The `ACTION_CHANNEL_ID` is the channel where the bot will send "actioned" messages, to indicate whether a particular piece of feedback was actioned by the server owner or not.

![Actioned](/assets/actioned_example.png)

Channel IDs can be obtained by right-clicking on a channel and selecting "Copy Channel ID" at the very bottom.

_The bot must have permission to read and send messages in the feedback and action channels._

The `BLACKLIST` and `ID_BLACKLIST` are lists of user IDs and channel IDs respectively, who are not allowed to use the bot. This is useful for blacklisting users who abuse the bot or are otherwise not welcome.

### Running the bot

Execute the below command from the project's root directory -

```bash
python3 src/main.py path/to/config.json --export_dir path/to/export/dir
```

## Commands

The bot supports the following slash commands -

| Command                                            | Description                                                     |
|----------------------------------------------------|-----------------------------------------------------------------|
| `/fd <character> <move>`                           | Get frame data of a particular character's move                 |
| `/ms <character> <condition> <frames> <situation>` | Find a character's moves that match a particular frame scenario |
| `/<character> <move>`                              | Get frame data of a particular character's move                 |
| `/feedback <message>`                              | Send feedback to the bot owner                                  |
| `/help`                                            | Get help on the bot's usage                                     |

## Testing

To install the development dependencies, run -

```bash
python3 -m pip install -e .[dev]
```

The bot uses `pytest` for testing. To run the tests, execute the below command from the project's root directory -

```bash
python3 -m pytest
```
