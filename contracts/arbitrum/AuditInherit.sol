pragma solidity ^0.8.0;

interface IDatabase {
    enum STATUS {
        NOTAUDITED,
        PENDING,
        PASSED,
        FAILED,
        REFUNDED
    }

    function beingAudited() external;

    function auditStatus(address contractAddress_) external view returns (STATUS status_);
}

/// @title   Audit Inherit
/// @notice  Contract that audited contracts will inherit form
/// @author  Hyacinth
abstract contract AuditInherit {
    /// MODIFIERS ///

    modifier auditPassed() {
        _auditedPassed();
        _;
    }

    /// ERRORS ///

    /// @notice Error for if the audit has not passed
    error AuditNotPassed();

    /// STATE VARIABLES ///

    /// @notice Address of database
    address public constant database = 0x65cE96DfAC95B811867cbB275a03a656c55c7f84;

    /// CONSTRUCTOR ///

    constructor() {
        IDatabase(database).beingAudited();
    }

    /// INTERNAL VIEW FUNCTION ///

    function _auditedPassed() internal view {
        IDatabase.STATUS status_ = IDatabase(database).auditStatus(address(this));
        if (status_ != IDatabase.STATUS.PASSED) revert AuditNotPassed();
    }
}
