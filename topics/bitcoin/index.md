---#3  std::unordered_map<...>::find (__x=..., this=<optimized out>) at /usr/include/c++/8/bits/unordered_map.h:920
#4  LookupBlockIndex (hash=...) at ./validation.h:436
#5  interfaces::(anonymous namespace)::LockImpl::getBlockHeight (this=<optimized out>, hash=...) at interfaces/chain.cpp:34
#6  interfaces::(anonymous namespace)::LockImpl::getBlockDepth (this=0x555556ebb4c0, hash=...) at interfaces/chain.cpp:43
#7  CMerkleTx::GetDepthInMainChain (this=this@entry=0x7fff7ce26940, locked_chain=...) at wallet/wallet.cpp:4479
#8  CWalletTx::IsTrusted (this=this@entry=0x7fff7ce26940, locked_chain=...) at wallet/wallet.cpp:2081
#9  CWallet::GetUnconfirmedBalance (this=0x7fff7dc19150) at /usr/include/c++/8/bits/unique_ptr.h:342
#10 interfaces::(anonymous namespace)::WalletImpl::getBalances (this=0x7fff7d4e66a0) at /usr/include/c++/8/bits/shared_ptr_base.h:1307
#11 interfaces::(anonymous namespace)::WalletImpl::tryGetBalances (this=0x7fff7d4e66a0, balances=..., num_blocks=@0x7fffffffd9cc: -1) at interfaces/wallet.cpp:388
#12 WalletModel::pollBalanceChanged (this=0x5555569caef0) at /usr/include/c++/8/bits/unique_ptr.h:342
aliases: bitcoin-wallet, bitcoins, bitcoin-payment
created_by: Satoshi Nakamoto
display_name: Bitcoin
github_url: https://github.com/bitcoin/bitcoin
logo: bitcoin.png
released: January 3, 2009
short_description: Bitcoin is a cryptocurrency developed by Satoshi Nakamoto.
topic: bitcoin
url: https://bitcoin.org/en/
wikipedia_url: https://en.wikipedia.org/wiki/Bitcoin
---
Bitcoin is a cryptocurrency developed by Satoshi Nakamoto in 2009. Bitcoin is used as a digital payment system. Rather than use traditional currency (USD, YEN, EURO, etc.) individuals may trade in, or even mine Bitcoin. It is a peer-to-peer system, and transactions may take place between users directly.
