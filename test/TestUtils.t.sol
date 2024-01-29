// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import { TransparentUpgradeableProxy } from "../src/mock/MockProxyAdmin.sol";
import "stringutils/strings.sol";

abstract contract TestUtils is Test {
    using strings for *;

    function _deployUpgradeable(address proxyAdmin, address implementation, bytes memory data) internal returns (address) {
        return address(new TransparentUpgradeableProxy(implementation, proxyAdmin, data));
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
}
