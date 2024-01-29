// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import { TransparentUpgradeableProxy } from "../src/mock/MockProxyAdmin.sol";
import { ILayerZeroEndpoint } from "lz/lzApp/interfaces/ILayerZeroEndpoint.sol";
import "forge-std/Test.sol";
import "stringutils/strings.sol";
import "../src/Constants.sol";

abstract contract TestUtils is Test {
    using strings for *;

    function _lzEndPoint(uint256 chainId) internal returns (ILayerZeroEndpoint) {
        // TODO temporary check if LZ updated their sdk
        if (chainId == CHAIN_GNOSIS) {
            return ILayerZeroEndpoint(0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4);
        } else if (chainId == CHAIN_POLYGONZKEVM) {
            return ILayerZeroEndpoint(0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4);
        } else if (chainId == CHAIN_BASE) {
            return ILayerZeroEndpoint(0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
        } else if (chainId == CHAIN_CELO) {
            return ILayerZeroEndpoint(0x3A73033C0b1407574C76BdBAc67f126f6b4a9AA9);
        } else if (chainId == CHAIN_LINEA) {
            return ILayerZeroEndpoint(0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
        }

        string[] memory cmd = new string[](3);
        cmd[0] = "node";
        cmd[1] = "utils/layerZeroEndpoint.js";
        cmd[2] = vm.toString(chainId);

        bytes memory res = vm.ffi(cmd);
        if (res.length == 0) revert("Chain not supported");
        return ILayerZeroEndpoint(address(bytes20(res)));
    }

    function _getAllContracts(uint256 chainId) internal returns (address[] memory allContracts) {
        string[] memory cmd = new string[](3);
        cmd[0] = "node";
        cmd[1] = "utils/getAllContracts.js";
        cmd[2] = vm.toString(chainId);

        bytes memory res = vm.ffi(cmd);
        // When process exit code is 1, it will return an empty bytes "0x"
        if (res.length == 0) revert("Chain not supported");
        allContracts = abi.decode(res, (address[]));
    }

    function _chainToContract(uint256 chainId, ContractType name) internal returns (address) {
        string[] memory cmd = new string[](4);
        cmd[0] = "node";
        cmd[1] = "utils/contractAddress.js";
        cmd[2] = vm.toString(chainId);

        if (name == ContractType.AgEUR) cmd[3] = "agEUR";
        else if (name == ContractType.AgUSD) cmd[3] = "agUSD";
        else if (name == ContractType.AgEURLZ) cmd[3] = "agEURLz";
        else if (name == ContractType.AgUSDLZ) cmd[3] = "agUSDLz";
        else if (name == ContractType.Angle) cmd[3] = "angle";
        else if (name == ContractType.AngleLZ) cmd[3] = "angleLz";
        else if (name == ContractType.AngleDistributor) cmd[3] = "angleDistributor";
        else if (name == ContractType.AngleMiddleman) cmd[3] = "angleMiddleman";
        else if (name == ContractType.AngleRouter) cmd[3] = "angleRouter";
        else if (name == ContractType.CoreBorrow) cmd[3] = "coreBorrow";
        else if (name == ContractType.CoreMerkl) cmd[3] = "coreMerkl";
        else if (name == ContractType.DistributionCreator) cmd[3] = "distributionCreator";
        else if (name == ContractType.Distributor) cmd[3] = "distributor";
        else if (name == ContractType.FeeDistributor) cmd[3] = "feeDistributor";
        else if (name == ContractType.GaugeController) cmd[3] = "gaugeController";
        else if (name == ContractType.Governor) cmd[3] = "governor";
        else if (name == ContractType.GovernorMultisig) cmd[3] = "governorMultisig";
        else if (name == ContractType.GuardianMultisig) cmd[3] = "guardianMultisig";
        else if (name == ContractType.MerklMiddleman) cmd[3] = "merklMiddleman";
        else if (name == ContractType.ProposalReceiver) cmd[3] = "proposalReceiver";
        else if (name == ContractType.ProposalSender) cmd[3] = "proposalSender";
        else if (name == ContractType.ProxyAdmin) cmd[3] = "proxyAdmin";
        else if (name == ContractType.SmartWalletWhitelist) cmd[3] = "smartWalletWhitelist";
        else if (name == ContractType.StEUR) cmd[3] = "stEUR";
        else if (name == ContractType.StUSD) cmd[3] = "stUSD";
        else if (name == ContractType.Timelock) cmd[3] = "timelock";
        else if (name == ContractType.TransmuterAgEUR) cmd[3] = "transmuterAgEUR";
        else if (name == ContractType.TransmuterAgUSD) cmd[3] = "transmuterAgUSD";
        else if (name == ContractType.TreasuryAgEUR) cmd[3] = "treasuryAgEUR";
        else if (name == ContractType.TreasuryAgUSD) cmd[3] = "treasuryAgUSD";
        else if (name == ContractType.veANGLE) cmd[3] = "veANGLE";
        else if (name == ContractType.veBoost) cmd[3] = "veBoost";
        else if (name == ContractType.veBoostProxy) cmd[3] = "veBoostProxy";
        else revert("contract not supported");

        bytes memory res = vm.ffi(cmd);
        // When process exit code is 1, it will return an empty bytes "0x"
        if (res.length == 0) revert("Chain not supported");
        return address(bytes20(res));
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
        string[] memory cmd = new string[](3);
        cmd[0] = "node";
        cmd[1] = "utils/layerZeroChainIds.js";
        cmd[2] = vm.toString(chainId);

        bytes memory res = vm.ffi(cmd);
        if (res.length == 0) revert("Chain not supported");
        return uint16(_stringToUint(string(res)));
    }

    function _getChainIdFromLZChainId(uint256 lzChainId) internal returns (uint16) {
        string[] memory cmd = new string[](3);
        cmd[0] = "node";
        cmd[1] = "utils/chainIdFromLZChainIds.js";
        cmd[2] = vm.toString(lzChainId);

        bytes memory res = vm.ffi(cmd);
        return uint16(_stringToUint(string(res)));
    }

    function _generateSelectors(string memory _facetName) internal returns (bytes4[] memory selectors) {
        return _generateSelectors(_facetName, 3);
    }

    function _generateSelectors(string memory _facetName, uint256 retries) internal returns (bytes4[] memory selectors) {
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

    function _slice(bytes memory _bytes, uint256 _start, uint256 _length) internal pure returns (bytes memory) {
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
                let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
                let end := add(mc, _length)

                for {
                    // Same logic as for mc is applied and additionally the start offset specified for the method is added
                    let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
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

    function _deployUpgradeable(address proxyAdmin, address implementation, bytes memory data) internal returns (address) {
        return address(new TransparentUpgradeableProxy(implementation, proxyAdmin, data));
    }
}
