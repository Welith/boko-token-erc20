# Boko Token ERC20

This is my first draft of creating an ERC20 token. It does not have any additional logic. It is merely the beginning.

## How to build

1. As all other repos in my profile, you will need to:

```bash
git clone https://github.com/Welith/boko-token-erc20
cd boko-token-erc20
```

2. I have create a `Makefile` for your convinience, which will help you deploy. The first thing we want to do is build the app:

```bash
make build
```

3. Then, you have two choices, deploy on a local testnet (with anvil):

```bash
make anvil

Open a new terminal

make deploy
```

4. If you want you can deploy to Sepolia as well. However, for this you will need to create a foundry account + a Sepolia testing account in your Metamask

```bash
 make deploy ARGS="--network sepolia"
 ```