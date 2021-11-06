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
    convstatus = FactoryBot.create(
      :taxonomy,
      title: "Convention status",
      allow_multiple: true,
    )
    FactoryBot.create(
      :measuretype_taxonomy,
      taxonomy: convstatus,
      measuretype: intl
    )
    FactoryBot.create(
      :measuretype_taxonomy,
      taxonomy: convstatus,
      measuretype: regional_seas
    )
    # Admin. type taxonomy - applies to reg. seas conventions
    admintype = FactoryBot.create(
      :taxonomy,
      title: "Administration type",
      allow_multiple: true,
    )
    FactoryBot.create(
      :measuretype_taxonomy,
      taxonomy: admintype,
      measuretype: regional_seas
    )
    # Strategy type taxonomy - applies to nat. and reg. strategies
    strategytype = FactoryBot.create(
      :taxonomy,
      title: "Strategy type",
      allow_multiple: true,
    )
    FactoryBot.create(
      :measuretype_taxonomy,
      taxonomy: strategytype,
      measuretype: regional
    )
    FactoryBot.create(
      :measuretype_taxonomy,
      taxonomy: strategytype,
      measuretype: national
    )
    # Initiative type taxonomy - applies to initiatives
    initiativetype = FactoryBot.create(
      :taxonomy,
      title: "Initiative type",
      allow_multiple: true,
    )
    FactoryBot.create(
      :measuretype_taxonomy,
      taxonomy: initiativetype,
      measuretype: initiatives
    )

    # Group type taxonomy - applies to groups
    grouptype = FactoryBot.create(
      :taxonomy,
      title: "Type of group",
      allow_multiple: false,
    )
    FactoryBot.create(
      :actortype_taxonomy,
      taxonomy: grouptype,
      actortype: groups
    )

    # Org sector taxonomy - applies to orgs
    orgsector = FactoryBot.create(
      :taxonomy,
      title: "Sector",
      allow_multiple: false,
    )
    FactoryBot.create(
      :actortype_taxonomy,
      taxonomy: orgsector,
      actortype: orgs
    )

    # Org type taxonomy - applies to orgs, child of org sector
    # TODO: link parent
    orgtype = FactoryBot.create(
      :taxonomy,
      title: "Type of organisation",
      allow_multiple: false,
    )
    FactoryBot.create(
      :actortype_taxonomy,
      taxonomy: orgtype,
      actortype: orgs
    )
    # class type taxonomy - applies to classes
    classtype = FactoryBot.create(
      :taxonomy,
      title: "Type of country classification",
      allow_multiple: false,
    )
    FactoryBot.create(
      :actortype_taxonomy,
      taxonomy: classtype,
      actortype: classes
    )
    # country status taxonomy - applies to countries
    countrystatus = FactoryBot.create(
      :taxonomy,
      title: "Country status",
      allow_multiple: false,
    )
    FactoryBot.create(
      :actortype_taxonomy,
      taxonomy: countrystatus,
      actortype: countries
    )

    # Set up categories ########################################################
    # Convention status taxonomy
    FactoryBot.create(
      :category,
      taxonomy: convstatus,
      title: "Signed"
    )
    FactoryBot.create(
      :category,
      taxonomy: convstatus,
      title: "Adopted"
    )
    FactoryBot.create(
      :category,
      taxonomy: convstatus,
      title: "In force"
    )
    FactoryBot.create(
      :category,
      taxonomy: convstatus,
      title: "Reaffirmed"
    )
    FactoryBot.create(
      :category,
      taxonomy: convstatus,
      title: "Concluded"
    )
    FactoryBot.create(
      :category,
      taxonomy: convstatus,
      title: "Established"
    )
    FactoryBot.create(
      :category,
      taxonomy: convstatus,
      title: "Launched"
    )
    # Admin. type taxonomy
    FactoryBot.create(
      :category,
      taxonomy: admintype,
      title: "Established and administered independently",
      short_title: "Independent"
    )
    FactoryBot.create(
      :category,
      taxonomy: admintype,
      title: "Established under UN Environment, administered independently",
      short_title: "UN established"
    )
    FactoryBot.create(
      :category,
      taxonomy: admintype,
      title: "UN Environment-administered",
      short_title: "UN-administered"
    )
    # Strategy type taxonomy
    FactoryBot.create(
      :category,
      taxonomy: strategytype,
      title: "Plastic / marine litter strategy",
      short_title: "Plastic/ML"
    )
    FactoryBot.create(
      :category,
      taxonomy: strategytype,
      title: "Extendend Producer Responsibility policy",
      short_title: "EPR"
    )
    FactoryBot.create(
      :category,
      taxonomy: strategytype,
      title: "Strategy on microplastics",
      short_title: "Microplastics"
    )
    FactoryBot.create(
      :category,
      taxonomy: strategytype,
      title: "Strategy on single-use plastics",
      short_title: "Single-use"
    )
    # Initiative type taxonomy
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Alliance"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Association"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Campaign"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Coalition"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Commitment"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Community"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Conference"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Forum"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "High-level panel"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Initiative"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Knowledge centre"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Movement"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Multi-donor fund"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Network"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Other"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Partnership"
    )
    FactoryBot.create(
      :category,
      taxonomy: initiativetype,
      title: "Platform"
    )

    # Group type taxonomy
    FactoryBot.create(
      :category,
      taxonomy: grouptype,
      title: "Intergovernmental"
    )
    FactoryBot.create(
      :category,
      taxonomy: grouptype,
      title: "Mixed"
    )
    # Org sector taxonomy
    FactoryBot.create(
      :category,
      taxonomy: orgsector,
      title: "Civil society"
    )
    FactoryBot.create(
      :category,
      taxonomy: orgsector,
      title: "Private sector"
    )
    FactoryBot.create(
      :category,
      taxonomy: orgsector,
      title: "Science & research"
    )
    FactoryBot.create(
      :category,
      taxonomy: orgsector,
      title: "Public sector"
    )
    # Org type taxonomy
    # TODO: link with Science & R.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Academia"
    )
    # TODO: link with Science & R.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Think tank"
    )
    # TODO: link with Civil Society
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Foundation"
    )
    # TODO: link with Civil Society
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Fund"
    )
    # TODO: link with Civil S.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Non-Governmental Organisation",
      short_title: "NGO"
    )
    # TODO: link with Civil S.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Other civil society"
    )
    # TODO: link with Private S.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Consultancy"
    )
    # TODO: link with Private S.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Finance & investment"
    )
    # TODO: link with Private S.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Manufacturing & retail"
    )
    # TODO: link with Private S.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Recycling & disposal"
    )
    # TODO: link with Private S.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Social business"
    )
    # TODO: link with Private S.
    FactoryBot.create(
      :category,
      taxonomy: orgtype,
      title: "Other private sector"
    )

    # class type taxonomy
    FactoryBot.create(
      :category,
      taxonomy: classtype,
      title: "Development (Natural Earth)",
      short_title: "Development"
    )
    FactoryBot.create(
      :category,
      taxonomy: classtype,
      title: "Income (World Bank)",
      short_title: "Income"
    )
    FactoryBot.create(
      :category,
      taxonomy: classtype,
      title: "Operational lending (World Bank)",
      short_title: "Lending"
    )
    FactoryBot.create(
      :category,
      taxonomy: classtype,
      title: "Official development assistance",
      short_title: "ODA"
    )
    # country status taxonomy
    FactoryBot.create(
      :category,
      taxonomy: countrystatus,
      title: "Country"
    )
    FactoryBot.create(
      :category,
      taxonomy: countrystatus,
      title: "Dependency"
    )
    FactoryBot.create(
      :category,
      taxonomy: countrystatus,
      title: "Disputed"
    )
    FactoryBot.create(
      :category,
      taxonomy: countrystatus,
      title: "Indeterminate"
    )
    FactoryBot.create(
      :category,
      taxonomy: countrystatus,
      title: "Sovereign country"
    )
  end

  def development_seeds!
    return unless User.count.zero?

    FactoryBot.create(:user).tap do |user|
      log "Seed user created: Log in with #{user.email} and password #{user.password}"
      user.roles << Role.find_by(name: "manager")
      user.save!
    end
  end

  def log(msg, level: :info)
    Rails.logger.public_send(level, msg)
  end
end

Seeds.new
