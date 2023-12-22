using CleanArchitecture.SME.Web.ContributorEndpoints;

namespace CleanArchitecture.SME.Web.Endpoints.ContributorEndpoints;

public class ContributorListResponse
{
  public List<ContributorRecord> Contributors { get; set; } = new();
}
