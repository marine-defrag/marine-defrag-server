# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seeds
  def initialize
    base_seeds!
    run_env_seeds!
  end

  private

  def run_env_seeds!
    seeder = "#{Rails.env}_seeds!"
    if respond_to?(seeder.to_sym, true)
      send(seeder)
    else
      log "Seeds for #{Rails.env} not defined, skipping.", level: :warn
    end
  end

  def base_seeds!
    # Set up user roles
    Role.new(name: "admin", friendly_name: "Admin").save!
    Role.new(name: "manager", friendly_name: "Manager").save!
    Role.new(name: "analyst", friendly_name: "Analyst").save!

    # set up Actor Types ########################################################
    countries = Actortype.new(
      title: "Country",
      is_active: true,
      is_target: true
    )
    countries.save!

    orgs = Actortype.new(
      title: "Organisation",
      is_active: true,
      is_target: false
    )
    orgs.save!

    classes = Actortype.new(
      title: "Class",
      is_active: false,
      is_target: true,
      has_members: true
    )
    classes.save!

    regions = Actortype.new(
      title: "Region",
      is_active: false,
      is_target: true,
      has_members: true
    )
    regions.save!

    groups = Actortype.new(
      title: "Group",
      is_active: true,
      is_target: false,
      has_members: true
    )
    groups.save!

    # set up Activity Types ########################################################
    intl = Measuretype.new(
      title: "International ",
      has_parent: true,
      has_target: false
    )
    intl.save!

    regional_seas = Measuretype.new(
      title: "Regional Seas Conventions ",
      has_parent: false,
      has_target: true
    )
    regional_seas.save!

    regional = Measuretype.new(
      title: "Regional Strategies",
      has_parent: false,
      has_target: false
    )
    regional.save!

    national = Measuretype.new(
      title: "National Strategies",
      has_parent: false,
      has_target: false
    )
    national.save!

    donations = Measuretype.new(
      title: "Donor activities",
      has_parent: true,
      has_target: true
    )
    donations.save!

    initiatives = Measuretype.new(
      title: "Initiatives",
      has_parent: true,
      has_target: true
    )
    initiatives.save!

    # Set up taxonomies ########################################################
    # Convention status taxonomy - applies to int. and reg. seas conventions
    convstatus = Taxonomy.create!(
      title: "Convention status",
      allow_multiple: true,
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: convstatus,
      measuretype: intl
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: convstatus,
      measuretype: regional_seas
    )
    # Admin. type taxonomy - applies to reg. seas conventions
    admintype = Taxonomy.create!(
      title: "Administration type",
      allow_multiple: true,
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: admintype,
      measuretype: regional_seas
    )
    # Strategy type taxonomy - applies to nat. and reg. strategies
    strategytype = Taxonomy.create!(
      title: "Strategy type",
      allow_multiple: true,
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: strategytype,
      measuretype: regional
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: strategytype,
      measuretype: national
    )
    # Initiative type taxonomy - applies to initiatives
    initiativetype = Taxonomy.create!(
      title: "Initiative type",
      allow_multiple: true,
    )
    MeasuretypeTaxonomy.create!(
      taxonomy: initiativetype,
      measuretype: initiatives
    )

    # Group type taxonomy - applies to groups
    grouptype = Taxonomy.create!(
      title: "Type of group",
      allow_multiple: false,
    )
    ActortypeTaxonomy.create!(
      taxonomy: grouptype,
      actortype: groups
    )

    # Org sector taxonomy - applies to orgs
    orgsector = Taxonomy.create!(
      title: "Sector",
      allow_multiple: false,
    )
    ActortypeTaxonomy.create!(
      taxonomy: orgsector,
      actortype: orgs
    )

    # Org type taxonomy - applies to orgs, child of org sector
    # TODO: link parent
    orgtype = Taxonomy.create!(
      title: "Type of organisation",
      allow_multiple: false,
    )
    ActortypeTaxonomy.create!(
      taxonomy: orgtype,
      actortype: orgs
    )
    # class type taxonomy - applies to classes
    classtype = Taxonomy.create!(
      title: "Type of country classification",
      allow_multiple: false,
    )
    ActortypeTaxonomy.create!(
      taxonomy: classtype,
      actortype: classes
    )
    # country status taxonomy - applies to countries
    countrystatus = Taxonomy.create!(
      title: "Country status",
      allow_multiple: false,
    )
    ActortypeTaxonomy.create!(
      taxonomy: countrystatus,
      actortype: countries
    )

    # Set up categories ########################################################
    # Convention status taxonomy
    Category.create!(
      taxonomy: convstatus,
      title: "Signed"
    )
    Category.create!(
      taxonomy: convstatus,
      title: "Adopted"
    )
    Category.create!(
      taxonomy: convstatus,
      title: "In force"
    )
    Category.create!(
      taxonomy: convstatus,
      title: "Reaffirmed"
    )
    Category.create!(
      taxonomy: convstatus,
      title: "Concluded"
    )
    Category.create!(
      taxonomy: convstatus,
      title: "Established"
    )
    Category.create!(
      taxonomy: convstatus,
      title: "Launched"
    )
    # Admin. type taxonomy
    Category.create!(
      taxonomy: admintype,
      title: "Established and administered independently",
      short_title: "Independent"
    )
    Category.create!(
      taxonomy: admintype,
      title: "Established under UN Environment, administered independently",
      short_title: "UN established"
    )
    Category.create!(
      taxonomy: admintype,
      title: "UN Environment-administered",
      short_title: "UN-administered"
    )
    # Strategy type taxonomy
    Category.create!(
      taxonomy: strategytype,
      title: "Plastic / marine litter strategy",
      short_title: "Plastic/ML"
    )
    Category.create!(
      taxonomy: strategytype,
      title: "Extendend Producer Responsibility policy",
      short_title: "EPR"
    )
    Category.create!(
      taxonomy: strategytype,
      title: "Strategy on microplastics",
      short_title: "Microplastics"
    )
    Category.create!(
      taxonomy: strategytype,
      title: "Strategy on single-use plastics",
      short_title: "Single-use"
    )
    # Initiative type taxonomy
    Category.create!(
      taxonomy: initiativetype,
      title: "Alliance"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Association"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Campaign"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Coalition"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Commitment"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Community"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Conference"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Forum"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "High-level panel"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Initiative"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Knowledge centre"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Movement"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Multi-donor fund"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Network"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Other"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Partnership"
    )
    Category.create!(
      taxonomy: initiativetype,
      title: "Platform"
    )

    # Group type taxonomy
    Category.create!(
      taxonomy: grouptype,
      title: "Intergovernmental"
    )
    Category.create!(
      taxonomy: grouptype,
      title: "Mixed"
    )
    # Org sector taxonomy
    Category.create!(
      taxonomy: orgsector,
      title: "Civil society"
    )
    Category.create!(
      taxonomy: orgsector,
      title: "Private sector"
    )
    Category.create!(
      taxonomy: orgsector,
      title: "Science & research"
    )
    Category.create!(
      taxonomy: orgsector,
      title: "Public sector"
    )
    # Org type taxonomy
    # TODO: link with Science & R.
    Category.create!(
      taxonomy: orgtype,
      title: "Academia"
    )
    # TODO: link with Science & R.
    Category.create!(
      taxonomy: orgtype,
      title: "Think tank"
    )
    # TODO: link with Civil Society
    Category.create!(
      taxonomy: orgtype,
      title: "Foundation"
    )
    # TODO: link with Civil Society
    Category.create!(
      taxonomy: orgtype,
      title: "Fund"
    )
    # TODO: link with Civil S.
    Category.create!(
      taxonomy: orgtype,
      title: "Non-Governmental Organisation",
      short_title: "NGO"
    )
    # TODO: link with Civil S.
    Category.create!(
      taxonomy: orgtype,
      title: "Other civil society"
    )
    # TODO: link with Private S.
    Category.create!(
      taxonomy: orgtype,
      title: "Consultancy"
    )
    # TODO: link with Private S.
    Category.create!(
      taxonomy: orgtype,
      title: "Finance & investment"
    )
    # TODO: link with Private S.
    Category.create!(
      taxonomy: orgtype,
      title: "Manufacturing & retail"
    )
    # TODO: link with Private S.
    Category.create!(
      taxonomy: orgtype,
      title: "Recycling & disposal"
    )
    # TODO: link with Private S.
    Category.create!(
      taxonomy: orgtype,
      title: "Social business"
    )
    # TODO: link with Private S.
    Category.create!(
      taxonomy: orgtype,
      title: "Other private sector"
    )

    # class type taxonomy
    Category.create!(
      taxonomy: classtype,
      title: "Development (Natural Earth)",
      short_title: "Development"
    )
    Category.create!(
      taxonomy: classtype,
      title: "Income (World Bank)",
      short_title: "Income"
    )
    Category.create!(
      taxonomy: classtype,
      title: "Operational lending (World Bank)",
      short_title: "Lending"
    )
    Category.create!(
      taxonomy: classtype,
      title: "Official development assistance",
      short_title: "ODA"
    )
    # country status taxonomy
    Category.create!(
      taxonomy: countrystatus,
      title: "Country"
    )
    Category.create!(
      taxonomy: countrystatus,
      title: "Dependency"
    )
    Category.create!(
      taxonomy: countrystatus,
      title: "Disputed"
    )
    Category.create!(
      taxonomy: countrystatus,
      title: "Indeterminate"
    )
    Category.create!(
      taxonomy: countrystatus,
      title: "Sovereign country"
    )
  end

  def development_seeds!
    return unless User.count.zero?
  end

  def log(msg, level: :info)
    Rails.logger.public_send(level, msg)
  end
end

Seeds.new
