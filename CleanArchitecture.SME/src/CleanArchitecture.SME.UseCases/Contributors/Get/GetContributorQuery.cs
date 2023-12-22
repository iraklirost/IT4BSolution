using Ardalis.Result;
using Ardalis.SharedKernel;

namespace CleanArchitecture.SME.UseCases.Contributors.Get;

public record GetContributorQuery(int ContributorId) : IQuery<Result<ContributorDTO>>;
