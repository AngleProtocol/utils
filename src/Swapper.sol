// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import { SafeERC20, IERC20 } from "oz/token/ERC20/utils/SafeERC20.sol";

/// @title Swapper
/// @author Angle Labs, Inc.
/// @dev Abstract contract for swapping tokens using a router/aggregator
abstract contract Swapper {
    using SafeERC20 for IERC20;

    /*//////////////////////////////////////////////////////////////
                               ERRORS
    //////////////////////////////////////////////////////////////*/

    error SwapError();
    error ZeroAddress();

    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/

    /**
     *  @notice Event emitted when the swap router is updated
     */
    event SwapRouterUpdated(address newSwapRouter);
    /**
     *  @notice Event emitted when the token proxy is updated
     */
    event TokenTransferAddressUpdated(address newTokenTransferAddress);

     /*//////////////////////////////////////////////////////////////
                                MODIFIERS
    //////////////////////////////////////////////////////////////*/

    modifier noZeroAddress(address targetAddress) {
        if (targetAddress == address(0)) {
            revert ZeroAddress();
        }
        _;
    }

    /*//////////////////////////////////////////////////////////////
                            MUTABLE VARIABLES
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice address of the router/aggregator
     */
    address public swapRouter;
    /**
     * @notice address to approve to transfer tokens to
     */
    address public tokenTransferAddress;

    /*//////////////////////////////////////////////////////////////
                               CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor(address initialSwapRouter, address initialTokenTransferAddress) {
        swapRouter = initialSwapRouter;
        tokenTransferAddress = initialTokenTransferAddress;
    }

    /*//////////////////////////////////////////////////////////////
                             ADMIN FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    function setSwapRouter(address newSwapRouter) external noZeroAddress(newSwapRouter) {
       swapRouter = newSwapRouter;

        emit SwapRouterUpdated(newSwapRouter);
    }

    function setTokenTransferAddress(address newTokenTransferAddress) external noZeroAddress(newTokenTransferAddress) {
        tokenTransferAddress = newTokenTransferAddress;

        emit TokenTransferAddressUpdated(newTokenTransferAddress);
    }

    /*//////////////////////////////////////////////////////////////
                             SWAP FUNCTIONS
    //////////////////////////////////////////////////////////////*/

    /**
     * @notice Approve the router/aggregator to spend the token if needed
     * @param token address of the token to approve
     * @param spender address of the router/aggregator
     * @param amount amount to approve
     */
    function _approveTokenIfNeeded(address token, address spender, uint256 amount) internal {
        uint256 allowance = IERC20(token).allowance(address(this), spender);
        if (allowance < amount) {
            IERC20(token).safeIncreaseAllowance(spender, amount - allowance);
        }
    }

    /**
     * @notice Perform the swap using the router/aggregator
     * @param callData bytes to call the router/aggregator
     */
    function _performRouterSwap(bytes memory callData) internal {
        (bool success, bytes memory retData) = swapRouter.call(callData);

        if (!success) {
            if (retData.length != 0) {
                assembly {
                    revert(add(32, retData), mload(retData))
                }
            }
            revert SwapError();
        }
    }

    /**
     * @notice Swap tokens using the router/aggregator
     * @param tokens array of tokens to swap
     * @param callDatas array of bytes to call the router/aggregator
     * @param amounts array of amounts to swap
     */
    function _swapCalldata(address[] calldata tokens, bytes[] calldata callDatas, uint256[] calldata amounts) internal {
        uint256 length = tokens.length;
        for (uint256 i; i < length; ++i) {
            _approveTokenIfNeeded(tokens[i], tokenTransferAddress, amounts[i]);
            _performRouterSwap(callDatas[i]);
        }
    }

    /**
     * @notice Swap tokens using the router/aggregator
     * @param tokens array of tokens to swap
     * @param callDatas array of bytes to call the router/aggregator
     * @param amounts array of amounts to swap
     */
    function _swap(address[] memory tokens, bytes[] memory callDatas, uint256[] memory amounts) internal {
        uint256 length = tokens.length;
        for (uint256 i; i < length; ++i) {
            _approveTokenIfNeeded(tokens[i], tokenTransferAddress, amounts[i]);
            _performRouterSwap(callDatas[i]);
        }
    }
}