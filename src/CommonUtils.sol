// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import {ILayerZeroEndpoint} from "lz/lzApp/interfaces/ILayerZeroEndpoint.sol";
import {TransparentUpgradeableProxy} from "oz/proxy/transparent/TransparentUpgradeableProxy.sol";
import {CommonBase, VmSafe} from "forge-std/Base.sol";

import {JsonReader} from "./JsonReader.sol";
import {strings} from "stringutils/strings.sol";
import {ContractType, Constants} from "./Constants.sol";

contract CommonUtils is CommonBase, JsonReader {
    using strings for *;
    bytes32 private constant EUR_HASH = keccak256(abi.encodePacked("EUR"));
    bytes32 private constant USD_HASH = keccak256(abi.encodePacked("USD"));
    bytes32 private constant ANGLE_HASH = keccak256(abi.encodePacked("ANGLE"));

    mapping(uint256 => uint256) internal forkIdentifier;
    uint256 public arbitrumFork;
    uint256 public avalancheFork;
    uint256 public ethereumFork;
    uint256 public optimismFork;
    uint256 public polygonFork;
    uint256 public gnosisFork;
    uint256 public bnbFork;
    uint256 public celoFork;
    uint256 public polygonZkEVMFork;
    uint256 public baseFork;
    uint256 public lineaFork;
    uint256 public mantleFork;
    uint256 public modeFork;
    uint256 public blastFork;
    uint256 public xlayerFork;
    uint256 public chainFork;
    uint256 public fantomFork;
    uint256 public auroraFork;
    uint256 public thunderCoreFork;
    uint256 public coreDaoFork;
    uint256 public taikoFork;
    uint256 public fuseFork;
    uint256 public immutableFork;
    uint256 public scrollFork;
    uint256 public mantaFork;
    uint256 public seiFork;
    uint256 public fraxtalFork;
    uint256 public astarFork;
    uint256 public astarZkEVMFork;
    uint256 public rootstockFork;
    uint256 public moonbeamFork;
    uint256 public skaleFork;
    uint256 public worldchainFork;
    uint256 public liskFork;
    uint256 public etherlinkFork;
    uint256 public artheraFork;
    uint256 public swellFork;

    function setUpForks() public virtual {
        if (vm.envExists("ETH_NODE_URI_ARBITRUM")) {
            arbitrumFork = vm.createFork(vm.envString("ETH_NODE_URI_ARBITRUM"));
            forkIdentifier[Constants.CHAIN_ARBITRUM] = arbitrumFork;
        }
        if (vm.envExists("ETH_NODE_URI_AVALANCHE")) {
            avalancheFork = vm.createFork(
                vm.envString("ETH_NODE_URI_AVALANCHE")
            );
            forkIdentifier[Constants.CHAIN_AVALANCHE] = avalancheFork;
        }
        if (vm.envExists("ETH_NODE_URI_MAINNET")) {
            ethereumFork = vm.createFork(vm.envString("ETH_NODE_URI_MAINNET"));
            forkIdentifier[Constants.CHAIN_ETHEREUM] = ethereumFork;
        }
        if (vm.envExists("ETH_NODE_URI_OPTIMISM")) {
            optimismFork = vm.createFork(vm.envString("ETH_NODE_URI_OPTIMISM"));
            forkIdentifier[Constants.CHAIN_OPTIMISM] = optimismFork;
        }
        if (vm.envExists("ETH_NODE_URI_POLYGON")) {
            polygonFork = vm.createFork(vm.envString("ETH_NODE_URI_POLYGON"));
            forkIdentifier[Constants.CHAIN_POLYGON] = polygonFork;
        }
        if (vm.envExists("ETH_NODE_URI_GNOSIS")) {
            gnosisFork = vm.createFork(vm.envString("ETH_NODE_URI_GNOSIS"));
            forkIdentifier[Constants.CHAIN_GNOSIS] = gnosisFork;
        }
        if (vm.envExists("ETH_NODE_URI_BSC")) {
            bnbFork = vm.createFork(vm.envString("ETH_NODE_URI_BSC"));
            forkIdentifier[Constants.CHAIN_BNB] = bnbFork;
        }
        if (vm.envExists("ETH_NODE_URI_CELO")) {
            celoFork = vm.createFork(vm.envString("ETH_NODE_URI_CELO"));
            forkIdentifier[Constants.CHAIN_CELO] = celoFork;
        }
        if (vm.envExists("ETH_NODE_URI_POLYGON_ZKEVM")) {
            polygonZkEVMFork = vm.createFork(
                vm.envString("ETH_NODE_URI_POLYGON_ZKEVM")
            );
            forkIdentifier[Constants.CHAIN_POLYGONZKEVM] = polygonZkEVMFork;
        }
        if (vm.envExists("ETH_NODE_URI_BASE")) {
            baseFork = vm.createFork(vm.envString("ETH_NODE_URI_BASE"));
            forkIdentifier[Constants.CHAIN_BASE] = baseFork;
        }
        if (vm.envExists("ETH_NODE_URI_LINEA")) {
            lineaFork = vm.createFork(vm.envString("ETH_NODE_URI_LINEA"));
            forkIdentifier[Constants.CHAIN_LINEA] = lineaFork;
        }
        if (vm.envExists("ETH_NODE_URI_MANTLE")) {
            mantleFork = vm.createFork(vm.envString("ETH_NODE_URI_MANTLE"));
            forkIdentifier[Constants.CHAIN_MANTLE] = mantleFork;
        }
        if (vm.envExists("ETH_NODE_URI_MODE")) {
            modeFork = vm.createFork(vm.envString("ETH_NODE_URI_MODE"));
            forkIdentifier[Constants.CHAIN_MODE] = modeFork;
        }
        if (vm.envExists("ETH_NODE_URI_BLAST")) {
            blastFork = vm.createFork(vm.envString("ETH_NODE_URI_BLAST"));
            forkIdentifier[Constants.CHAIN_BLAST] = blastFork;
        }
        if (vm.envExists("ETH_NODE_URI_XLAYER")) {
            xlayerFork = vm.createFork(vm.envString("ETH_NODE_URI_XLAYER"));
            forkIdentifier[Constants.CHAIN_XLAYER] = xlayerFork;
        }
        if (vm.envExists("ETH_NODE_URI_FORK")) {
            chainFork = vm.createFork(vm.envString("ETH_NODE_URI_FORK"));
            forkIdentifier[Constants.CHAIN_FORK] = chainFork;
        }
        if (vm.envExists("ETH_NODE_URI_FANTOM")) {
            fantomFork = vm.createFork(vm.envString("ETH_NODE_URI_FANTOM"));
            forkIdentifier[Constants.CHAIN_FANTOM] = fantomFork;
        }
        if (vm.envExists("ETH_NODE_URI_AURORA")) {
            auroraFork = vm.createFork(vm.envString("ETH_NODE_URI_AURORA"));
            forkIdentifier[Constants.CHAIN_AURORA] = auroraFork;
        }
        if (vm.envExists("ETH_NODE_URI_THUNDERCORE")) {
            thunderCoreFork = vm.createFork(
                vm.envString("ETH_NODE_URI_THUNDERCORE")
            );
            forkIdentifier[Constants.CHAIN_THUNDERCORE] = thunderCoreFork;
        }
        if (vm.envExists("ETH_NODE_URI_COREDAO")) {
            coreDaoFork = vm.createFork(vm.envString("ETH_NODE_URI_COREDAO"));
            forkIdentifier[Constants.CHAIN_COREDAO] = coreDaoFork;
        }
        if (vm.envExists("ETH_NODE_URI_TAIKO")) {
            taikoFork = vm.createFork(vm.envString("ETH_NODE_URI_TAIKO"));
            forkIdentifier[Constants.CHAIN_TAIKO] = taikoFork;
        }
        if (vm.envExists("ETH_NODE_URI_FUSE")) {
            fuseFork = vm.createFork(vm.envString("ETH_NODE_URI_FUSE"));
            forkIdentifier[Constants.CHAIN_FUSE] = fuseFork;
        }
        if (vm.envExists("ETH_NODE_URI_IMMUTABLE")) {
            immutableFork = vm.createFork(
                vm.envString("ETH_NODE_URI_IMMUTABLE")
            );
            forkIdentifier[Constants.CHAIN_IMMUTABLE] = immutableFork;
        }
        if (vm.envExists("ETH_NODE_URI_SCROLL")) {
            scrollFork = vm.createFork(vm.envString("ETH_NODE_URI_SCROLL"));
            forkIdentifier[Constants.CHAIN_SCROLL] = scrollFork;
        }
        if (vm.envExists("ETH_NODE_URI_MANTA")) {
            mantaFork = vm.createFork(vm.envString("ETH_NODE_URI_MANTA"));
            forkIdentifier[Constants.CHAIN_MANTA] = mantaFork;
        }
        if (vm.envExists("ETH_NODE_URI_SEI")) {
            seiFork = vm.createFork(vm.envString("ETH_NODE_URI_SEI"));
            forkIdentifier[Constants.CHAIN_SEI] = seiFork;
        }
        if (vm.envExists("ETH_NODE_URI_FRAXTAL")) {
            fraxtalFork = vm.createFork(vm.envString("ETH_NODE_URI_FRAXTAL"));
            forkIdentifier[Constants.CHAIN_FRAXTAL] = fraxtalFork;
        }
        if (vm.envExists("ETH_NODE_URI_ASTAR")) {
            astarFork = vm.createFork(vm.envString("ETH_NODE_URI_ASTAR"));
            forkIdentifier[Constants.CHAIN_ASTAR] = astarFork;
        }
        if (vm.envExists("ETH_NODE_URI_ASTARZKEVM")) {
            astarZkEVMFork = vm.createFork(
                vm.envString("ETH_NODE_URI_ASTARZKEVM")
            );
            forkIdentifier[Constants.CHAIN_ASTARZKEVM] = astarZkEVMFork;
        }
        if (vm.envExists("ETH_NODE_URI_ROOTSTOCK")) {
            rootstockFork = vm.createFork(
                vm.envString("ETH_NODE_URI_ROOTSTOCK")
            );
            forkIdentifier[Constants.CHAIN_ROOTSTOCK] = rootstockFork;
        }
        if (vm.envExists("ETH_NODE_URI_MOONBEAM")) {
            moonbeamFork = vm.createFork(vm.envString("ETH_NODE_URI_MOONBEAM"));
            forkIdentifier[Constants.CHAIN_MOONBEAM] = moonbeamFork;
        }
        if (vm.envExists("ETH_NODE_URI_SKALE")) {
            skaleFork = vm.createFork(vm.envString("ETH_NODE_URI_SKALE"));
            forkIdentifier[Constants.CHAIN_SKALE] = skaleFork;
        }
        if (vm.envExists("ETH_NODE_URI_WORLDCHAIN")) {
            worldchainFork = vm.createFork(
                vm.envString("ETH_NODE_URI_WORLDCHAIN")
            );
            forkIdentifier[Constants.CHAIN_WORLDCHAIN] = worldchainFork;
        }
        if (vm.envExists("ETH_NODE_URI_LISK")) {
            liskFork = vm.createFork(vm.envString("ETH_NODE_URI_LISK"));
            forkIdentifier[Constants.CHAIN_LISK] = liskFork;
        }
        if (vm.envExists("ETH_NODE_URI_ETHERLINK")) {
            etherlinkFork = vm.createFork(
                vm.envString("ETH_NODE_URI_ETHERLINK")
            );
            forkIdentifier[Constants.CHAIN_ETHERLINK] = etherlinkFork;
        }
        if (vm.envExists("ETH_NODE_URI_ARTHERA")) {
            artheraFork = vm.createFork(vm.envString("ETH_NODE_URI_ARTHERA"));
            forkIdentifier[Constants.CHAIN_ARTHERA] = artheraFork;
        }
        if (vm.envExists("ETH_NODE_URI_SWELL")) {
            swellFork = vm.createFork(vm.envString("ETH_NODE_URI_SWELL"));
            forkIdentifier[Constants.CHAIN_SWELL] = swellFork;
        }
    }

    function _lzEndPoint(
        uint256 chainId
    ) internal returns (ILayerZeroEndpoint) {
        // TODO temporary check if LZ updated their sdk
        if (chainId == Constants.CHAIN_GNOSIS) {
            return
                ILayerZeroEndpoint(0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4);
        } else if (chainId == Constants.CHAIN_POLYGONZKEVM) {
            return
                ILayerZeroEndpoint(0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4);
        } else if (chainId == Constants.CHAIN_BASE) {
            return
                ILayerZeroEndpoint(0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
        } else if (chainId == Constants.CHAIN_CELO) {
            return
                ILayerZeroEndpoint(0x3A73033C0b1407574C76BdBAc67f126f6b4a9AA9);
        } else if (chainId == Constants.CHAIN_LINEA) {
            return
                ILayerZeroEndpoint(0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
        } else if (chainId == Constants.CHAIN_BLAST) {
            return
                ILayerZeroEndpoint(0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
        } else if (chainId == Constants.CHAIN_XLAYER) {
            return
                ILayerZeroEndpoint(0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
        }

        string[] memory cmd = new string[](4);
        cmd[0] = "node";
        cmd[1] = "utils/forwardUtils.js";
        cmd[2] = "layerZeroEndpoint";
        cmd[3] = vm.toString(chainId);

        VmSafe.FfiResult memory res = vm.tryFfi(cmd);
        if (res.exitCode != 0) revert("Chain not supported");
        return ILayerZeroEndpoint(address(bytes20(res.stdout)));
    }

    function _getAllContracts(
        uint256 chainId
    ) internal view returns (address[] memory) {
        string memory json = readJsonFile(getPath());

        // Get all keys at the chain level (these are the contract categories)
        string memory chainPath = string.concat(".", vm.toString(chainId));
        string[] memory keys = vm.parseJsonKeys(json, chainPath);

        // Create dynamic arrays to store addresses
        address[] memory addresses = new address[](100); // Initial size
        uint256 count = 0;

        // Iterate through each key to collect addresses
        for (uint256 i = 0; i < keys.length; i++) {
            string memory key = keys[i];
            string memory fullPath = string.concat(chainPath, ".", key);

            // Try to parse as direct address
            try vm.parseJsonAddress(json, fullPath) returns (address addr) {
                if (addr != address(0)) {
                    addresses[count++] = addr;
                }
            } catch {
                // If not a direct address, try to parse nested objects
                try vm.parseJsonKeys(json, fullPath) returns (
                    string[] memory subKeys
                ) {
                    for (uint256 j = 0; j < subKeys.length; j++) {
                        string memory subPath = string.concat(
                            fullPath,
                            ".",
                            subKeys[j]
                        );
                        try vm.parseJsonAddress(json, subPath) returns (
                            address addr
                        ) {
                            if (addr != address(0)) {
                                addresses[count++] = addr;
                            }
                        } catch {}
                    }
                } catch {}
            }
        }

        // Create final array with exact size
        address[] memory result = new address[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = addresses[i];
        }

        return result;
    }

    function _getConnectedChains(
        string memory token
    ) internal returns (uint256[] memory, address[] memory) {
        uint256[] memory allChainIds = _getChainIds();
        uint256[] memory chainIds = new uint256[](0);
        address[] memory contracts = new address[](0);

        for (uint256 i = 0; i < allChainIds.length; i++) {
            address addr;
            if (keccak256(abi.encodePacked(token)) == EUR_HASH) {
                try
                    this.chainToContract(allChainIds[i], ContractType.AgEURLZ)
                returns (address _addr) {
                    addr = _addr;
                } catch {}
            } else if (keccak256(abi.encodePacked(token)) == USD_HASH) {
                try
                    this.chainToContract(allChainIds[i], ContractType.AgUSDLZ)
                returns (address _addr) {
                    addr = _addr;
                } catch {}
            } else if (keccak256(abi.encodePacked(token)) == ANGLE_HASH) {
                try
                    this.chainToContract(allChainIds[i], ContractType.AngleLZ)
                returns (address _addr) {
                    addr = _addr;
                } catch {}
            }

            if (addr != address(0)) {
                assembly {
                    // Get the current length of the arrays
                    let oldLen := mload(chainIds)
                    let newLen := add(oldLen, 1)

                    // Calculate new memory locations
                    let newChainIds := add(mload(0x40), 0x20)
                    let newContracts := add(
                        newChainIds,
                        mul(add(newLen, 1), 0x20)
                    )

                    // Store lengths
                    mstore(newChainIds, newLen)
                    mstore(newContracts, newLen)

                    // Copy existing chainIds
                    let srcChainIds := add(chainIds, 0x20)
                    let destChainIds := add(newChainIds, 0x20)
                    for {
                        let j := 0
                    } lt(j, oldLen) {
                        j := add(j, 1)
                    } {
                        mstore(
                            add(destChainIds, mul(j, 0x20)),
                            mload(add(srcChainIds, mul(j, 0x20)))
                        )
                    }

                    // Copy existing contracts
                    let srcContracts := add(contracts, 0x20)
                    let destContracts := add(newContracts, 0x20)
                    for {
                        let j := 0
                    } lt(j, oldLen) {
                        j := add(j, 1)
                    } {
                        mstore(
                            add(destContracts, mul(j, 0x20)),
                            mload(add(srcContracts, mul(j, 0x20)))
                        )
                    }

                    // Add new elements
                    mstore(
                        add(destChainIds, mul(oldLen, 0x20)),
                        mload(add(allChainIds, add(0x20, mul(i, 0x20))))
                    )
                    mstore(add(destContracts, mul(oldLen, 0x20)), addr)

                    // Update free memory pointer
                    mstore(0x40, add(newContracts, mul(add(newLen, 1), 0x20)))

                    // Update array pointers
                    chainIds := newChainIds
                    contracts := newContracts
                }
            }
        }

        return (chainIds, contracts);
    }

    /// @notice Get all chains from the SDK
    function _getChainIds() internal view returns (uint256[] memory) {
        // Parse the entire JSON object first
        string memory json = readJsonFile(getPath());

        // Get the object keys (chain IDs) at the root level
        string[] memory chainIds = vm.parseJsonKeys(json, ".");

        // Convert string array of chain IDs to uint256 array
        uint256[] memory result = new uint256[](chainIds.length);
        for (uint256 i = 0; i < chainIds.length; i++) {
            result[i] = vm.parseUint(chainIds[i]);
        }

        return result;
    }

    /// @notice Get all chains where a specific contract type is deployed
    function _getChainIdsWithDeployedContract(
        ContractType contractType
    ) internal view returns (uint256[] memory deployedChains) {
        string memory json = readJsonFile(getPath());
        string[] memory chainIds = vm.parseJsonKeys(json, ".");

        // First count how many chains have the contract deployed
        uint256 deployedCount = 0;
        for (uint256 i = 0; i < chainIds.length; i++) {
            try this.chainToContract(vm.parseUint(chainIds[i]), contractType) {
                deployedCount++;
            } catch {
                continue;
            }
        }

        // Create array of exact size and populate it
        deployedChains = new uint256[](deployedCount);
        uint256 currentIndex = 0;
        for (uint256 i = 0; i < chainIds.length; i++) {
            try this.chainToContract(vm.parseUint(chainIds[i]), contractType) {
                deployedChains[currentIndex] = vm.parseUint(chainIds[i]);
                currentIndex++;
            } catch {
                continue;
            }
        }
    }

    function chainToContract(
        uint256 chainId,
        ContractType name
    ) external view returns (address) {
        return _chainToContract(chainId, name);
    }

    function _chainToContract(
        uint256 chainId,
        ContractType name
    ) internal view returns (address) {
        return this.readAddress(chainId, _getContractPath(name));
    }

    /// @dev Helper function to get the JSON path for a contract type
    function _getContractPath(
        ContractType name
    ) internal pure returns (string memory) {
        if (name == ContractType.AgEUR) return "EUR.AgToken";
        else if (name == ContractType.AgUSD) return "USD.AgToken";
        else if (name == ContractType.AgEURLZ) return "EUR.bridges.LayerZero";
        else if (name == ContractType.AgUSDLZ) return "USD.bridges.LayerZero";
        else if (name == ContractType.Angle) return "ANGLE";
        else if (name == ContractType.AngleLZ) return "bridges.LayerZero";
        else if (name == ContractType.AngleDistributor)
            return "AngleDistributor";
        else if (name == ContractType.AngleMiddleman) return "Middleman";
        else if (name == ContractType.AngleRouter) return "AngleRouterV2";
        else if (name == ContractType.CoreBorrow) return "CoreBorrow";
        else if (name == ContractType.CoreMerkl) return "Merkl.CoreMerkl";
        else if (name == ContractType.Disputer) return "Merkl.Disputer";
        else if (name == ContractType.DistributionCreator)
            return "Merkl.DistributionCreator";
        else if (name == ContractType.Distributor) return "Merkl.Distributor";
        else if (name == ContractType.FeeDistributor)
            return "FeeDistributor_sanUSDC_EUR";
        else if (name == ContractType.GaugeController) return "GaugeController";
        else if (name == ContractType.Governor) return "AngleGovernor";
        else if (name == ContractType.GovernorMultisig) return "Governor";
        else if (name == ContractType.GuardianMultisig) return "Guardian";
        else if (name == ContractType.MerklMiddleman)
            return "MerklGaugeMiddleman";
        else if (name == ContractType.ProposalReceiver)
            return "ProposalReceiver";
        else if (name == ContractType.ProposalSender) return "ProposalSender";
        else if (name == ContractType.ProxyAdmin) return "ProxyAdmin";
        else if (name == ContractType.SmartWalletWhitelist)
            return "SmartWalletWhitelist";
        else if (name == ContractType.StEUR) return "EUR.Savings";
        else if (name == ContractType.StUSD) return "USD.Savings";
        else if (name == ContractType.Timelock) return "Timelock";
        else if (name == ContractType.TransmuterAgEUR) return "EUR.Transmuter";
        else if (name == ContractType.TransmuterAgUSD) return "USD.Transmuter";
        else if (name == ContractType.TreasuryAgEUR) return "EUR.Treasury";
        else if (name == ContractType.TreasuryAgUSD) return "USD.Treasury";
        else if (name == ContractType.veANGLE) return "veANGLE";
        else if (name == ContractType.veBoost) return "veBoost";
        else if (name == ContractType.veBoostProxy) return "veBoostProxy";
        else if (name == ContractType.ProxyAdminGuardian)
            return "ProxyAdminGuardian";
        else if (name == ContractType.AngleLabsMultisig) return "AngleLabs";
        else if (name == ContractType.FlashLoan) return "FlashAngle";
        else if (name == ContractType.MultiBlockHarvester)
            return "USD.MultiBlockHarvester";
        else if (name == ContractType.GenericHarvester)
            return "USD.GenericHarvester";
        else if (name == ContractType.Harvester) return "USD.Harvester";
        else if (name == ContractType.Rebalancer) return "USD.Rebalancer";
        else if (name == ContractType.MulticallWithFailure)
            return "MulticallWithFailure";
        else if (name == ContractType.OracleNativeUSD) return "OracleNativeUSD";
        else if (name == ContractType.Swapper) return "Swapper";
        else if (name == ContractType.AngleHelpers) return "AngleHelpers";
        else revert("contract not supported");
    }

    function _stringToUint(string memory s) internal pure returns (uint) {
        bytes memory b = bytes(s);
        uint result = 0;
        for (uint256 i = 0; i < b.length; i++) {
            uint256 c = uint256(uint8(b[i]));
            if (c >= 48 && c <= 57) {
                result = result * 10 + (c - 48);
            }
        }
        return result;
    }

    function _getLZChainId(uint256 chainId) internal returns (uint16) {
        string[] memory cmd = new string[](4);
        cmd[0] = "node";
        cmd[1] = "utils/forwardUtils.js";
        cmd[2] = "layerZeroChainIds";
        cmd[3] = vm.toString(chainId);

        VmSafe.FfiResult memory res = vm.tryFfi(cmd);
        if (res.exitCode != 0) revert("Chain not supported");
        return uint16(_stringToUint(string(res.stdout)));
    }

    function _getChainIdFromLZChainId(
        uint256 lzChainId
    ) internal returns (uint16) {
        string[] memory cmd = new string[](4);
        cmd[0] = "node";
        cmd[1] = "utils/forwardUtils.js";
        cmd[2] = "chainIdFromLZChainIds";
        cmd[3] = vm.toString(lzChainId);

        VmSafe.FfiResult memory res = vm.tryFfi(cmd);
        if (res.exitCode != 0) revert("Chain not supported");
        return uint16(_stringToUint(string(res.stdout)));
    }

    function _generateSelectors(
        string memory _facetName
    ) internal returns (bytes4[] memory selectors) {
        return _generateSelectors(_facetName, 3);
    }

    function _generateSelectors(
        string memory _facetName,
        uint256 retries
    ) internal returns (bytes4[] memory selectors) {
        //get string of contract methods
        string[] memory cmd = new string[](4);
        cmd[0] = "forge";
        cmd[1] = "inspect";
        cmd[2] = _facetName;
        cmd[3] = "methods";
        bytes memory res = vm.ffi(cmd);
        string memory st = string(res);

        // if empty, try again
        if (bytes(st).length == 0) {
            if (retries != 0) {
                return _generateSelectors(_facetName, retries - 1);
            }
        }

        // extract function signatures and take first 4 bytes of keccak
        strings.slice memory s = st.toSlice();
        strings.slice memory delim = ":".toSlice();
        strings.slice memory delim2 = ",".toSlice();
        selectors = new bytes4[]((s.count(delim)));
        for (uint i = 0; i < selectors.length; ++i) {
            s.split('"'.toSlice());
            selectors[i] = bytes4(s.split(delim).until('"'.toSlice()).keccak());
            s.split(delim2);
        }
        return selectors;
    }

    function _slice(
        bytes memory _bytes,
        uint256 _start,
        uint256 _length
    ) internal pure returns (bytes memory) {
        require(_length + 31 >= _length, "slice_overflow");
        require(_bytes.length >= _start + _length, "slice_outOfBounds");

        bytes memory tempBytes;

        // Check length is 0. `iszero` return 1 for `true` and 0 for `false`.
        assembly {
            switch iszero(_length)
            case 0 {
                // Get a location of some free memory and store it in tempBytes as
                // Solidity does for memory variables.
                tempBytes := mload(0x40)

                // Calculate length mod 32 to handle slices that are not a multiple of 32 in size.
                let lengthmod := and(_length, 31)

                // tempBytes will have the following format in memory: <length><data>
                // When copying data we will offset the start forward to avoid allocating additional memory
                // Therefore part of the length area will be written, but this will be overwritten later anyways.
                // In case no offset is require, the start is set to the data region (0x20 from the tempBytes)
                // mc will be used to keep track where to copy the data to.
                let mc := add(
                    add(tempBytes, lengthmod),
                    mul(0x20, iszero(lengthmod))
                )
                let end := add(mc, _length)

                for {
                    // Same logic as for mc is applied and additionally the start offset specified for the method is added
                    let cc := add(
                        add(
                            add(_bytes, lengthmod),
                            mul(0x20, iszero(lengthmod))
                        ),
                        _start
                    )
                } lt(mc, end) {
                    // increase `mc` and `cc` to read the next word from memory
                    mc := add(mc, 0x20)
                    cc := add(cc, 0x20)
                } {
                    // Copy the data from source (cc location) to the slice data (mc location)
                    mstore(mc, mload(cc))
                }

                // Store the length of the slice. This will overwrite any partial data that
                // was copied when having slices that are not a multiple of 32.
                mstore(tempBytes, _length)

                // update free-memory pointer
                // allocating the array padded to 32 bytes like the compiler does now
                // To set the used memory as a multiple of 32, add 31 to the actual memory usage (mc)
                // and remove the modulo 32 (the `and` with `not(31)`)
                mstore(0x40, and(add(mc, 31), not(31)))
            }
            // if we want a zero-length slice let's just return a zero-length array
            default {
                tempBytes := mload(0x40)
                // zero out the 32 bytes slice we are about to return
                // we need to do it because Solidity does not garbage collect
                mstore(tempBytes, 0)

                // update free-memory pointer
                // tempBytes uses 32 bytes in memory (even when empty) for the length.
                mstore(0x40, add(tempBytes, 0x20))
            }
        }

        return tempBytes;
    }

    function _deployUpgradeable(
        address proxyAdmin,
        address implementation,
        bytes memory data
    ) internal returns (address) {
        return
            address(
                new TransparentUpgradeableProxy(
                    implementation,
                    proxyAdmin,
                    data
                )
            );
    }
}
