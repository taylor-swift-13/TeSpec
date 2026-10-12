"""Errors shared by job preparation and executor result validation."""


class JobError(ValueError):
    """The job cannot be executed safely or unambiguously."""
