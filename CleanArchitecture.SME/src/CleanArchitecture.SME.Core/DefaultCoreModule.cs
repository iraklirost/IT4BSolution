using Autofac;
using CleanArchitecture.SME.Core.Interfaces;
using CleanArchitecture.SME.Core.Services;

namespace CleanArchitecture.SME.Core;

/// <summary>
/// An Autofac module that is responsible for wiring up services defined in the Core project.
/// </summary>
public class DefaultCoreModule : Module
{
  protected override void Load(ContainerBuilder builder)
  {
    builder.RegisterType<DeleteContributorService>()
        .As<IDeleteContributorService>().InstancePerLifetimeScope();
  }
}
