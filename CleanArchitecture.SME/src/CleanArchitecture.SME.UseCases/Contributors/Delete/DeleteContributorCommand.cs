using Ardalis.Result;
using Ardalis.SharedKernel;

namespace CleanArchitecture.SME.UseCases.Contributors.Delete;

public record DeleteContributorCommand(int ContributorId) : ICommand<Result>;
