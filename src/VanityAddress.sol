// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.12;

import "stringutils/strings.sol";
import "forge-std/Script.sol";
import { StdAssertions } from "forge-std/Test.sol";
import { stdJson } from "forge-std/StdJson.sol";
import { console } from "forge-std/console.sol";
import "../src/Constants.sol";

contract VanityAddress is Script, StdAssertions {
    using stdJson for string;

    function _findDeploymentAddress(
        bytes32 salt,
        bytes memory initCode
    ) internal pure returns (address deploymentAddress) {
        deploymentAddress = address(
            uint160( // downcast to match the address type.
                uint256( // convert to uint to truncate upper digits.
                    keccak256( // compute the CREATE2 hash using 4 inputs.
                        abi.encodePacked( // pack all inputs to the hash together.
                            hex"ff", // start with 0xff to distinguish from RLP.
                            IMMUTABLE_CREATE2_FACTORY_ADDRESS, // this contract will be the caller.
                            salt, // pass in the supplied salt value.
                            keccak256(abi.encodePacked(initCode)) // pass in the hash of initialization code.
                        )
                    )
                )
            )
        );
    }

    function minePrefix(bytes memory initCode, address deployer, uint24 prefix, uint256 initInt, uint256 iterations) internal pure returns (address computedAddress, uint256 i) {
        // Deploy diamond
        i = initInt;
        bool found = false;
        while (!found && i - initInt < iterations) {
            computedAddress = _findDeploymentAddress(
                bytes32(abi.encodePacked(deployer, abi.encodePacked(uint96(i)))),
                initCode
            );
            if (uint24(uint160(bytes20(computedAddress)) >> 136) == prefix) {
                found = true;
                break;
            }
            i = i + 1;
        }

        return (computedAddress, i);
    }

    function minePostfix(bytes memory initCode, address deployer, uint24 postfix, uint256 initInt, uint256 iterations) internal pure returns (address computedAddress, uint256 i) {
        // Deploy diamond
        bool found = false;
        while (!found && i - initInt < iterations) {
            computedAddress = _findDeploymentAddress(
                bytes32(abi.encodePacked(deployer, abi.encodePacked(uint96(i)))),
                initCode
            );
            if (uint24(uint160(bytes20(computedAddress))) == postfix) {
                found = true;
                break;
            }
            i = i + 1;
        }

        return (computedAddress, i);

    }

    function mine(bytes memory initCode, address deployer, uint24 prefix, uint24 postfix, uint256 initInt, uint256 iterations) internal pure returns (address computedAddress, uint256 i) {
        // Deploy diamond
        bool found = false;
        while (!found && i - initInt < iterations) {
            computedAddress = _findDeploymentAddress(
                bytes32(abi.encodePacked(deployer, abi.encodePacked(uint96(i)))),
                initCode
            );
            if (uint24(uint160(bytes20(computedAddress))) == postfix && uint24(uint160(bytes20(computedAddress)) >> 136) == prefix) {
                found = true;
                break;
            }
            i = i + 1;
        }

        return (computedAddress, i);
    }
}
