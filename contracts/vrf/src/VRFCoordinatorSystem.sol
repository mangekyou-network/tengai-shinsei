// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {System} from "@latticexyz/world/src/System.sol";

import {VRF} from "./VRF.sol";
import {VRFCoordinator} from "./VRFCoordinator.sol";
import {VRFCoordinatorAddress} from "./tables/VRFCoordinatorAddress.sol";

/// @title VRFCoordinatorSystem
/// @notice This contract handles requests and fulfillments of random words from a VRF.
contract VRFCoordinatorSystem is System, VRF {
    /// @notice Can be used to set the coordinator address.
    /// @param _coordinator The address of the coordinator.
    function setCoordinator(address _coordinator) external {
        VRFCoordinatorAddress.set(_coordinator);
    }

    function getWorldAddress() public view returns (address) {
        return _world();
    }

    /// @notice Requests random words from the VRF.
    /// @param _oracleId The address of the operator to get shares for.
    /// @param _requestConfirmations The number of shares for the operator.
    /// @param _callbackGasLimit The maximum amount of gas the callback can use.
    /// @param _nbWords The number of random words to request.
    /// @param _callbackSelector The selector of the callback function.
    function requestRandomWords(
        bytes32 _oracleId,
        uint32 _nbWords,
        uint16 _requestConfirmations,
        uint32 _callbackGasLimit,
        bytes4 _callbackSelector
    ) external returns (bytes32) {
        address coordinator = VRFCoordinatorAddress.get();
        bytes32 requestId = VRFCoordinator(coordinator).requestRandomWords(
            _oracleId,
            _nbWords,
            _requestConfirmations,
            _callbackGasLimit,
            _world(),
            _callbackSelector
        );
        return requestId;
    }
}
