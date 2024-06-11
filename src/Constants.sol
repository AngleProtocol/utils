// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

enum StablecoinType {
    EUR,
    USD
}

enum ContractType {
    AgEUR,
    AgUSD,
    AgEURLZ,
    AgUSDLZ,
    Angle,
    AngleLZ,
    AngleDistributor,
    AngleMiddleman,
    AngleRouter,
    CoreBorrow,
    CoreMerkl,
    DistributionCreator,
    Distributor,
    FeeDistributor,
    GaugeController,
    Governor,
    GovernorMultisig,
    GuardianMultisig,
    MerklMiddleman,
    ProposalReceiver,
    ProposalSender,
    ProxyAdmin,
    SmartWalletWhitelist,
    StEUR,
    StUSD,
    Timelock,
    TransmuterAgEUR,
    TransmuterAgUSD,
    TreasuryAgEUR,
    TreasuryAgUSD,
    veANGLE,
    veBoost,
    veBoostProxy,
    ProxyAdminGuardian
}

uint256 constant CHAIN_ETHEREUM = 1;
uint256 constant CHAIN_ARBITRUM = 42161;
uint256 constant CHAIN_AVALANCHE = 43114;
uint256 constant CHAIN_OPTIMISM = 10;
uint256 constant CHAIN_POLYGON = 137;
uint256 constant CHAIN_FANTOM = 250;
uint256 constant CHAIN_GNOSIS = 100;
uint256 constant CHAIN_BNB = 56;
uint256 constant CHAIN_CELO = 42220;
uint256 constant CHAIN_POLYGONZKEVM = 1101;
uint256 constant CHAIN_BASE = 8453;
uint256 constant CHAIN_LINEA = 59144;
uint256 constant CHAIN_MANTLE = 5000;
uint256 constant CHAIN_AURORA = 1313161554;
uint256 constant CHAIN_MODE = 34443;

uint256 constant BASE_18 = 1e18;
uint256 constant BASE_9 = 1e9;

address constant IMMUTABLE_CREATE2_FACTORY_ADDRESS = 0x0000000000FFe8B47B3e2130213B802212439497;
