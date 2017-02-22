using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using API.Models;

namespace API.Migrations
{
    [DbContext(typeof(ServiceContext))]
    [Migration("20170126094415_UserMigration")]
    partial class UserMigration
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
            modelBuilder
                .HasAnnotation("ProductVersion", "1.0.0-rtm-21431")
                .HasAnnotation("SqlServer:ValueGenerationStrategy", SqlServerValueGenerationStrategy.IdentityColumn);

            modelBuilder.Entity("API.Models.Configuration", b =>
                {
                    b.Property<Guid>("id")
                        .ValueGeneratedOnAdd();

                    b.Property<Guid>("PhoneId");

                    b.HasKey("id");

                    b.ToTable("Configuration");
                });

            modelBuilder.Entity("API.Models.Contact", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Address");

                    b.Property<string>("Email");

                    b.Property<string>("ImagePath");

                    b.Property<string>("Name");

                    b.Property<string>("PhoneNumber");

                    b.Property<string>("Surname");

                    b.Property<string>("Username")
                        .IsRequired();

                    b.HasKey("Id");

                    b.ToTable("Contact");
                });

            modelBuilder.Entity("API.Models.ContactList", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.HasKey("Id");

                    b.ToTable("ContactList");
                });

            modelBuilder.Entity("API.Models.Message", b =>
                {
                    b.Property<Guid>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("Content");

                    b.Property<Guid>("ReceiverId");

                    b.Property<Guid>("SenderId");

                    b.Property<DateTime?>("TimeReceived")
                        .IsRequired();

                    b.Property<DateTime>("TimeSent");

                    b.HasKey("Id");

                    b.ToTable("Message");
                });

            modelBuilder.Entity("API.Models.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd();

                    b.Property<string>("AccessToken");

                    b.Property<DateTime?>("BirthDate");

                    b.Property<string>("Email");

                    b.Property<string>("FirstName");

                    b.Property<bool?>("HideMe");

                    b.Property<string>("LastName");

                    b.Property<string>("Password");

                    b.Property<string>("PhoneNumber");

                    b.Property<int?>("Sex");

                    b.Property<int?>("SocialId");

                    b.Property<int>("SocialType");

                    b.Property<int?>("Status");

                    b.Property<string>("Username");

                    b.HasKey("Id");

                    b.ToTable("User");
                });
        }
    }
}
