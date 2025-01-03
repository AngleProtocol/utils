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
    AngleLabsMultisig,
    AngleMiddleman,
    AngleRouter,
    CoreBorrow,
    CoreMerkl,
    DistributionCreator,
    Distributor,
    Disputer,
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
    ProxyAdminGuardian,
    FlashLoan,
    MultiBlockHarvester,
    GenericHarvester,
    Harvester,
    Rebalancer,
    MulticallWithFailure,
    OracleNativeUSD,
    Swapper,
    AngleHelpers
}

library Constants {
    uint256 constant CHAIN_FORK = 0;
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
    uint256 constant CHAIN_BLAST = 81457;
    uint256 constant CHAIN_XLAYER = 196;
    uint256 constant CHAIN_THUNDERCORE = 108;
    uint256 constant CHAIN_COREDAO = 1116;
    uint256 constant CHAIN_TAIKO = 167000;
    uint256 constant CHAIN_FUSE = 122;
    uint256 constant CHAIN_IMMUTABLE = 13371;
    uint256 constant CHAIN_SCROLL = 534352;
    uint256 constant CHAIN_MANTA = 169;
    uint256 constant CHAIN_SEI = 1329;
    uint256 constant CHAIN_FRAXTAL = 252;
    uint256 constant CHAIN_ASTAR = 592;
    uint256 constant CHAIN_ASTARZKEVM = 3776;
    uint256 constant CHAIN_ROOTSTOCK = 30;
    uint256 constant CHAIN_MOONBEAM = 1284;
    uint256 constant CHAIN_SKALE = 2046399126;
    uint256 constant CHAIN_WORLDCHAIN = 480;
    uint256 constant CHAIN_LISK = 1135;
    uint256 constant CHAIN_ETHERLINK = 42793;
    uint256 constant CHAIN_ARTHERA = 10242;
    uint256 constant CHAIN_SWELL = 1923;

    uint256 constant BASE_18 = 1e18;
    uint256 constant BASE_9 = 1e9;

    address constant IMMUTABLE_CREATE2_FACTORY_ADDRESS =
        0x0000000000FFe8B47B3e2130213B802212439497;
}
