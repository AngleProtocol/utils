// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {CommonUtils} from "../src/CommonUtils.sol";
import {ContractType, Constants} from "../src/Constants.sol";
import {console} from "forge-std/console.sol";
contract CommonUtilsTest is Test, CommonUtils {
    function setUp() public {
        // Initialize any required setup
        setUpForks();
    }

    function test_ChainToContract() public {
        // Test AgEUR on Ethereum
        address agEurEth = _chainToContract(
            Constants.CHAIN_ETHEREUM,
            ContractType.AgEUR
        );
        assertNotEq(agEurEth, address(0), "AgEUR not found on Ethereum");

        // Test AgUSD on Arbitrum
        address agUsdArb = _chainToContract(
            Constants.CHAIN_ARBITRUM,
            ContractType.AgUSD
        );
        assertNotEq(agUsdArb, address(0), "AgUSD not found on Arbitrum");

        // Test ANGLE token on Ethereum
        address angleEth = _chainToContract(
            Constants.CHAIN_ETHEREUM,
            ContractType.Angle
        );
        assertNotEq(angleEth, address(0), "ANGLE not found on Ethereum");
    }

    function test_ChainToContractRevert() public {
        // Test with invalid contract type should revert
        vm.expectRevert();
        _chainToContract(Constants.CHAIN_AURORA, ContractType.Disputer); // Disputer not deployed (so far) on Aurora
    }

    function test_getChainIds() public {
        uint256[] memory chains = _getChainIds();
        assertEq(chains.length, 40, "Expected 40 chains");
    }

    function test_GetChainIdsWithDeployedContract() public {
        uint256[] memory chains = _getChainIdsWithDeployedContract(
            ContractType.DistributionCreator
        );
        assertEq(chains.length, 38, "Expected 38 chains");
    }

    function test_getChainIdsWithDeployedContract_MultiBlockHarvester() public {
        uint256[] memory chains = _getChainIdsWithDeployedContract(
            ContractType.MultiBlockHarvester
        );
        assertEq(chains.length, 1, "Expected 1 chains");
    }

    function test_getAllContracts() public {
        address[] memory contracts = _getAllContracts(Constants.CHAIN_ETHEREUM);
        address contractTest = contracts[0];
        assertEq(contractTest, 0x16CA2999e5f5e43aEc2e6c18896655b9B05a1560);
    }

    function test_getConnectedChains() public {
        (
            uint256[] memory chainIds,
            address[] memory contracts
        ) = _getConnectedChains("ANGLE");

        console.log("Number of connected chains:", chainIds.length);
        for (uint i = 0; i < chainIds.length; i++) {
            console.log("Chain ID %d:", chainIds[i]);
            console.log("Contract:", contracts[i]);
        }
    }
}
