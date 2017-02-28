using System;

namespace API.Helpers
{
    public static class Helper
    {
        public static Guid ConvertStringToGuid(string input)
        {
            Guid guid;

            if (Guid.TryParse(input, out guid))
            {
                return guid;
            }
            else
            {
                throw new ArgumentException("ConvertStringToGuid method throw an exception", nameof(input));
            }
        }
    }
}
