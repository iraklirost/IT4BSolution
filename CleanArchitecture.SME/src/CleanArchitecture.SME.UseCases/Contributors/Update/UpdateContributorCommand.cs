﻿using Ardalis.Result;
using Ardalis.SharedKernel;

namespace CleanArchitecture.SME.UseCases.Contributors.Update;

public record UpdateContributorCommand(int ContributorId, string NewName) : ICommand<Result<ContributorDTO>>;
