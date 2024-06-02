<h1 align="center">
  😍 + 🚀
  <br>IP Spaceship Prompt Section<br>
</h1>

<h4 align="center">
  A section for Spaceship prompt to show your current IP address based on <a href="https://github.com/spaceship-prompt/spaceship-section">The Official Project</a>
</h4>

<p align="center">
  <a href="https://github.com/TheArqsz/spaceship-ip/actions/workflows/ci.yaml">
    <img src="https://github.com/TheArqsz/spaceship-ip/actions/workflows/ci.yaml/badge.svg?style=flat-square"
      alt="GitHub Workflow Status" />
  </a>
</p>

<p align="center">
<figure>
    <img src="spaceship-ip-prompt.png" alt="Prompt Screenshot" />
  <figcaption style="text-align: center">Prompt with <code>*_PREFIX</code> set to <code>':'</code>, <code>*_SUFFIX</code> set to <code>''</code> and <code>*_PROMPT</code> set to <code>''</code> .</figcaption>
</figure>
</p>

## Info

This prompt will work on Linux and MacOS. It will choose your primary IP (outgoing to default gateway) - works with VPNs.

## Installing

You need to source this plugin somewhere in your dotfiles. Here's how to do it with some popular tools:

### [Oh-My-Zsh]

Execute this command to clone this repo into Oh-My-Zsh plugin's folder:

```zsh
git clone https://github.com/TheArqsz/spaceship-ip.git $ZSH_CUSTOM/plugins/spaceship-ip
```

Include `spaceship-ip` in Oh-My-Zsh plugins list:

```zsh
plugins=($plugins spaceship-ip)
```

### [zplug]

```zsh
zplug "TheArqsz/spaceship-ip"
```

### [antigen]

```zsh
antigen bundle "TheArqsz/spaceship-ip"
```

### [antibody]

```zsh
antibody bundle "TheArqsz/spaceship-ip"
```

### [zinit]

```zsh
zinit light "TheArqsz/spaceship-ip"
```

### [zgen]

```zsh
zgen load "TheArqsz/spaceship-ip"
```

### [sheldon]

```toml
[plugins.spaceship-ip]
github = "TheArqsz/spaceship-ip"
```

### Manual

If none of the above methods works for you, you can install Spaceship manually.

1. Clone this repo somewhere, for example to `$HOME/.zsh/spaceship-ip`.
2. Source this section in your `~/.zshrc`.

### Example

```zsh
mkdir -p "$HOME/.zsh"
git clone --depth=1 https://github.com/TheArqsz/spaceship-ip.git "$HOME/.zsh/spaceship-ip"
```

For initializing prompt system add this to your `.zshrc`:

```zsh title=".zshrc"
source "~/.zsh/spaceship-ip/spaceship-ip.plugin.zsh"
```

## Usage

After installing, add the following line to your `.zshrc` in order to include Ember section in the prompt:

```zsh
spaceship add ip
```

## Options

This section is shown only in directories within a foobar context.

| Variable                   |              Default               | Meaning                              |
| :------------------------- | :--------------------------------: | ------------------------------------ |
| `SPACESHIP_IP_SHOW`   |               `true`               | Show current section                 |
| `SPACESHIP_IP_USE_HOSTNAME`   |               `true`               | If necessary, use `hostname -I` for IP discovery (only Linux)        |
| `SPACESHIP_IP_PREFIX` | `$SPACESHIP_PROMPT_DEFAULT_PREFIX` | Prefix before the section                |
| `SPACESHIP_IP_SUFFIX` | `$SPACESHIP_PROMPT_DEFAULT_SUFFIX` | Suffix after the section                 |
| `SPACESHIP_IP_SYMBOL` |               `@ `                | Character to be shown before the IP |
| `SPACESHIP_IP_COLOR`  |             `#00ff5f`               | Color of the section                     |

## Contributing

First, thanks for your interest in contributing!

Contribute to this repo by submitting a pull request. Please use [conventional commits](https://www.conventionalcommits.org/), since this project adheres to [semver](https://semver.org/).

## License

MIT © [Arqsz](https://arqsz.net)

<!-- References -->

[Oh-My-Zsh]: https://ohmyz.sh/
[zplug]: https://github.com/zplug/zplug
[antigen]: https://antigen.sharats.me/
[antibody]: https://getantibody.github.io/
[zinit]: https://github.com/zdharma/zinit
[zgen]: https://github.com/tarjoilija/zgen
[sheldon]: https://sheldon.cli.rs/
